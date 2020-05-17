library(lattice)
library(ggplot2)
library(caret)
library(dplyr)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)
library(corrplot)
library(gbm)

if (!file.exists("./data")) {
  
  dir.create("./data")
  
}

training_Url <-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"

testing_Url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

training_csv <- "./data/pml-training.csv"

testing_csv  <- "./data/pml-testing.csv"

if (!file.exists(training_csv)) {
  
  download.file(training_Url, destfile=training_csv, method="curl")
  
}

if (!file.exists(testing_csv)) {
  
  download.file(testing_Url, destfile=testing_csv, method="curl")
  
}

training <- read.csv(trainFile)
testing <- read.csv(testFile)

str(training)
names(training)

pre <- function(rawData){
  rawData$user_name <- factor(rawData$user_name)
  rawData$new_window <- factor(rawData$new_window)
  preProcessed <- preProcess(rawData,method = c("center","scale","corr","nzv","conditionalX"))
  x <- predict(preProcessed,newdata = rawData)
  x<- x[, colSums(is.na(x)) == 0]
  return( dplyr::select_if(x, function(col) is.numeric(col) | is.factor(col)))
}

training$classe <- factor(training$classe)
data <- pre(training)
inTraining <- createDataPartition(data$classe, p = 0.8, list = FALSE)
trainData <- trainData[inTraining, ]
testData <- trainData[-inTraining, ]
dim(trainData)
dim(testData)

testing$problem_id <- factor(testing$problem_id)
validationData <- pre(testing)

head(trainData)
head(validationData)

set.seed(12345)
decisionTreeMod1 <- rpart(classe ~ ., data=trainData, method="class")
fancyRpartPlot(decisionTreeMod1)

predictTreeMod1 <- predict(decisionTreeMod1, testData, type = "class")
cmtree <- confusionMatrix(predictTreeMod1, testData$classe)
cmtree

controlRF <- trainControl(method="oob", number=3, verboseIter=FALSE)
modRF1 <- train(classe ~ ., data=trainData, method="rf", trControl=controlRF)
modRF1$finalModel

predictRF1 <- predict(modRF1, newdata=testData)
cmrf <- confusionMatrix(predictRF1, testData$classe)
cmrf

plot(modRF1)

plot(cmrf$table, col = cmrf$byClass, 
     main = paste("Random Forest Confusion Matrix: Accuracy =", 
                  round(cmrf$overall['Accuracy'], 4)))
set.seed(12345)
controlGBM <- trainControl(method = "repeatedcv", number = 5, repeats = 1)
modGBM  <- train(classe ~ ., data=trainData, method = "gbm", trControl = controlGBM, verbose = FALSE)
modGBM$finalModel
## A gradient boosted model with multinomial loss function.
## 150 iterations were performed.
## There were 52 predictors of which 42 had non-zero influence.
# print model summary
print(modGBM)

predictGBM <- predict(modGBM, newdata=testData)
cmGBM <- confusionMatrix(predictGBM, testData$classe)
cmGBM


Results <- predict(modRF1, newdata=validationData)
table(validationData$problem_id,Results)

