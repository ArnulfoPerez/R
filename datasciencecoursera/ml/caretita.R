library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y=spam$type, p=0.75, list = FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

set.seed(32343)
modelFit <- train(type ~ .,data=training,method="glm")
modelFit
modelFit$finalModel
predictions <- predict(modelFit, newdata = testing)
confusionMatrix(predictions,testing$type)

set.seed(32323)
folds <- createFolds(y=spam$type,k=10,list=TRUE,returnTrain = TRUE)
sapply(folds,length)
folds[[1]][1:10]

set.seed(32323)
folds <- createResample(y=spam$type,times=10,list=TRUE)
sapply(folds,length)
folds[[1]][1:10]

set.seed(32323)
tme <- 1:1000
folds <- createTimeSlices(y=tme,initialWindow=20,horizon = 10)
names(folds)
folds$train[[1]]
folds$test[[1]]