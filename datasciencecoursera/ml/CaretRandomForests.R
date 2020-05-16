library(caret)
library(ggplot2)
data("iris")
names(iris)
table(iris$Species)

inTrain <- createDataPartition(y=iris$Species,p=0.7,list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)
qplot(Petal.Width,Sepal.Width,colour=Species,data = iris)

modFit <- train(Species ~ ., method="rpart",data=training)
print(modFit$finalModel)

plot(modFit$finalModel,uniform=TRUE,main="Classification tree")
text(modFit$finalModel,use.n = TRUE, all = TRUE, cex = .8)

library(rattle)
fancyRpartPlot(modFit$finalModel)

predict(modFit, newdata = testing)

modFit <- train(Species ~ ., method="rf", prox = TRUE, data=training)
modFit
library(randomForest)
getTree(modFit$finalModel,k=2)

irisP <- classCenter(training[,c(3,4)], training$Species, modFit$finalModel$proximity)
irisP <- as.data.frame(irisP)
irisP$Species <- rownames(irisP)
p <- qplot(Petal.Width,Petal.Length,col=Species,data = training)
p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),size=5,shape=4,data = irisP)

pred <- predict(modFit,testing)
testing$predRight <- pred==testing$Species
table(pred,testing$Species)
