f (!file.exists("data")) {dir.create("data")}

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- "./data/getdata_ss06hid.csv"
download.file(fileURL, destfile = file, method = "curl")
#method curl did not worked

list.files("./data")

dateDownloaded <- date()
dateDownloaded

df = read.csv(file)
head(df)

names(df)
head(strsplit(names(df), "wgtp"))
strsplit(names(df), "wgtp")[[123]]

# Original data sources: 
#  http://data.worldbank.org/data-catalog/GDP-ranking-table
#  http://data.worldbank.org/data-catalog/ed-stats

library(data.table)
x <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
            header = TRUE, skip = 4, nrows = 190, select = c(1, 2, 4, 5),
            col.names=c("code", "rank", "name", "gdp"))
# only the first 190 rows have rankings
head(x)
mean(as.numeric(gsub(",","",x$gdp)))

countryNames <- x$name

x[grep("^United",countryNames), 3]

y <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",header = TRUE)
head(y)

z <- merge(x,y,by.x = "code",by.y = "CountryCode")
head(z)
nrow(z)

length(grep('Fiscal year end: June', z$Special.Notes))

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

dates <- as.Date(sampleTimes)

table(year(dates))

table(year(dates),weekdays(dates))


     