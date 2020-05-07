df = read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
head(df)
agricultureLogical <- (df$ACR == 3) & (df$AGS == 6)
head(agricultureLogical)
head(which(agricultureLogical), 3)
str(which(agricultureLogical))
filteredDf <- df[which(agricultureLogical),]

# install.packages('jpeg')
library(jpeg)

# Download the file
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              , 'jeff.jpg'
              , mode='wb' )

# Read the image
picture <- jpeg::readJPEG('jeff.jpg'
                          , native=TRUE)

# Get Sample Quantiles corressponding to given prob
quantile(picture, probs = c(0.3, 0.8) )

# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

# Original data sources: 
#  http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

# Answer: 
# 189
# 1: St. Kitts and Nevis

x <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",header = TRUE,skip = 4,nrows = 190)
# only the first 190 rows have rankings
head(x)
tail(x)
nrow(x)

y <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",header = TRUE)
head(y)

z <- merge(x,y,by.x = "X",by.y = "CountryCode")
head(z)
nrow(z)

head(x[order(x$X.1,decreasing = TRUE),],n=15)
x[order(x$X.1,decreasing = TRUE),][13,]
str(z)

tapply(z$X.1, z$Income.Group, mean)

library(Hmisc)
z$RankGroups <- cut2(z$X.1, g=5)
table(z$RankGroups, z$Income.Group)
                       