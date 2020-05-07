library(reshape2)
mtcars$carname = rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=(c("mpg","hp")))
head(carMelt,n=3)
tail(carMelt,n=3)

cylData <-dcast(carMelt, cyl ~ variable)
cylData

cylData <-dcast(carMelt, cyl ~ variable,mean)
cylData

head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)

spIns = split(InsectSprays$count,InsectSprays$spray)
spIns

sprCount = lapply(spIns,sum)
sprCount

sapply(spIns,sum)

ddply(InsectSprays,.(spray),summarise,sum=sum(count))
