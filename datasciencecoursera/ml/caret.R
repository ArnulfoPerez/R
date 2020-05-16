library("caret")
library(QSARdata)
data(Mutagen)
head(Mutagen_Outcome)
head(Mutagen_Dragon)
descr <- Mutagen_Dragon
mutagen <- Mutagen_Outcome
set.seed(1)
inTrain <- createDataPartition(mutagen, p = 3/4, list = FALSE)
trainDescr <- descr[inTrain,]
testDescr <- descr[-inTrain,]
trainClass <- mutagen[inTrain]
testClass <- mutagen[-inTrain]

zv = apply(trainDescr, 2, function(x) length(unique(x))==1)
sum(zv) # there are 3 zero-variance columns; remove them
which(zv)
trainDescr = trainDescr[ ,!zv]
testDescr = testDescr[ ,!zv]

prop.table(table(mutagen))
prop.table(table(trainClass)) 

ncol(trainDescr)
descrCorr <- cor(trainDescr)
highCorr <- findCorrelation(descrCorr, 0.90)
trainDescr <- trainDescr[, -highCorr]
testDescr <- testDescr[, -highCorr]
ncol(trainDescr) 

xTrans <- preProcess(trainDescr)
trainDescr <- predict(xTrans, trainDescr)
testDescr <- predict(xTrans, testDescr)

bootControl <- trainControl(number = 200)
set.seed(2)
svmFit <- train(trainDescr, trainClass, method = "svmRadial", tuneLength = 5, trControl = bootControl, scaled = FALSE)
svmfit
svmFit$finalModel 