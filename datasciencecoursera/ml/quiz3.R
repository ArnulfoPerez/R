library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

# Subset the data to a training set and testing set based on the Case variable in the data set.
# Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings.
# In the final model what would be the final model prediction for cases with the following variable values:
# TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1 = 2
# TotalIntench2 = 50,000; FiberWidthCh1 = 10; VarIntenCh4 = 100
# TotalIntench2 = 57,000; FiberWidthCh1 = 8; VarIntenCh4 = 100
# FiberWidthCh1 = 8; VarIntenCh4 = 100; PerimStatusCh1 = 2
# Solution:
  # 1. Subset the data to a training set and testing set based on the Case variable in the data set. 

inTrain <- createDataPartition(y = segmentationOriginal$Case, p = 0.6, list = FALSE) # 60% training
training <- segmentationOriginal[inTrain, ]
testing <- segmentationOriginal[-inTrain, ]
# 2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings. (The outcome class is contained in a factor variable called Class with levels "PS" for poorly segmented and "WS" for well segmented.)
set.seed(125)
modFit <- train(Class ~ ., method = "rpart", data = training)
## Loading required package: rpart
# 3. 
modFit$finalModel
## n= 1212 
## 
## node), split, n, loss, yval, (yprob)
##       * denotes terminal node
## 
## 1) root 1212 431 PS (0.64438944 0.35561056)  
##   2) TotalIntenCh2< 44626 572  37 PS (0.93531469 0.06468531) *
##   3) TotalIntenCh2>=44626 640 246 WS (0.38437500 0.61562500)  
##     6) FiberWidthCh1< 9.866294 172  55 PS (0.68023256 0.31976744) *
##     7) FiberWidthCh1>=9.866294 468 129 WS (0.27564103 0.72435897) *
suppressMessages(library(rattle))
library(rpart.plot)
fancyRpartPlot(modFit$finalModel)

library(pgmm)
data(olive)
olive = olive[,-1]

newdata = as.data.frame(t(colMeans(olive)))

modolive <- train(Area ~ ., method = "rpart", data = olive)
## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
## trainInfo, : There were missing values in resampled performance measures.
predict(modolive, newdata = newdata)

SAheartr<-load("C:\\Users\\arnul\\OneDrive\\Documents\\ws\\R\\ElemStatLearn\\data\\SAheart.RData") 
if(is.data.frame(SAheart)){
  names(SAheart)
}

#library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

missClass = function(values, prediction){sum(((prediction > 0.5) * 1) != values) / length(values)}
# What is the misclassification rate on the training set? What is the misclassification rate on the test set?
#  Solution:
set.seed(13234)
modelSA <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                 data = trainSA, method = "glm", family = "binomial")
missClass(testSA$chd, predict(modelSA, newdata = testSA))

missClass(trainSA$chd, predict(modelSA, newdata = trainSA))

#library(ElemStatLearn)
load("C:\\Users\\arnul\\OneDrive\\Documents\\ws\\R\\ElemStatLearn\\data\\vowel.train.RData") 
if(is.data.frame(vowel.train)){
  names(vowel.train)}
load("C:\\Users\\arnul\\OneDrive\\Documents\\ws\\R\\ElemStatLearn\\data\\vowel.test.RData") 
head(vowel.train)
head(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
library(randomForest)

modvowel <- randomForest(y ~ ., data = vowel.train)
order(varImp(modvowel), decreasing = T)