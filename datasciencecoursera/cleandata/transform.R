if(!file.exists("./data")) {dir.create("./data")}
fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

download.file(fileURL,destfile = "./data/restaurants.csv",method = "curl")
restData <- read.csv("./data/restaurants.csv")
summary(restData)
str(restData)
restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
table(restData$nearMe)
restData$zipWrong = ifelse(restData$zipCode<0,TRUE,FALSE)
table(restData$zipWrong,restData$zipCode<0)
restData$zipGroups = cut(restData$zipCode,breaks = quantile(restData$zipCode))
table(restData$zipGroups)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes","no"),size = 10,replace = TRUE)
yesnofac = factor(yesno,levels = c("yes","no"))
relevel(yesnofac,ref = "yes")
as.numeric(yesnofac)

library(Hmisc)
library(plyr)
restData2 = mutate(restData,zipGroups = cut2(zipCode,g=4))
table(restData2$zipGroups)