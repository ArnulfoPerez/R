if (!file.exists("data")) {dir.create("data")}

fileURL <- "https://data.baltimorecity.gov/api/views/h5i4-nb9a/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.csv", method = "auto")
#method curl did not worked

list.files("./data")

dateDownloaded <- date()
dateDownloaded

#cameraData <- read.table("./data/cameras.csv",sep=",",header=TRUE)
cameraData <- read.table("./data/cameras.csv",sep=",",header=TRUE, comment.char="")
head(cameraData)

fileURL <- "https://data.baltimorecity.gov/api/views/h5i4-nb9a/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileURL, destfile = "./data/rows.csv", method = "auto")

library(xlsx)

cameraData <- read.xlsx("./data/rows.xlsx",sheetIndex = 1,header=TRUE)
head(cameraData)

colIndex <- 2:3
rowIndex <- 1:4

cameraDataSubset <- read.xlsx("./data/rows.xlsx",sheetIndex = 1,header=TRUE,colIndex = colIndex,rowIndex = rowIndex)
head(cameraDataSubset)

  
library(XML)  

fileURL <- "https://www.w3schools.com/xml/simple.xml"

library(RCurl)
xData <- getURL(fileURL)
doc <- xmlParse(xData)

#doc <- xmlTreeParse(fileURL,useInternal=TRUE)
# xmlTreeParse does not support https.
rootNode <- xmlRoot(doc)
xmlName(rootNode)

xpathSApply(rootNode,"//name",xmlValue)

xpathSApply(rootNode,"//price",xmlValue)


fileURL <- "https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"

xData <- getURL(fileURL)
doc <- htmlParse(xData,useInternal = TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)

library(RMySQL)

ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.soe.ucsc.edu",port=3306)
result <- dbGetQuery(ucscDb,"show databases;")

dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(),user="genome",host="genome-mysql.soe.ucsc.edu",port=3306, db="hg19")
allTables <- dbListTables(hg19)
length(allTables)
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)

affyMisSmall <- fetch(query,n=10); dbClearResult(query);
dim(affyMisSmall)

dbDisconnect(hg19)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.10")

BiocManager::install("rhdf5")

library(rhdf5)

created = h5createFile("example.h5")
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

A = matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

df = data.frame(1L:5L,seq(0,1,length.out = 5),
                c("ab","cde","fghi","a","s"),stringsAsFactors=FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA

h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)

library(XML)
library(RCurl)
url <- getURL("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
html <- htmlTreeParse(url,useInternalNodes = TRUE)
xpathSApply(html,"//title",xmlValue)
xpathSApply(html,"//td[@class='gsc_a_t']",xmlValue)

library(httr)
html2 = GET("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText = TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)
