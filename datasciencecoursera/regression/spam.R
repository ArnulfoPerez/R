library(kernlab)
data(spam)
str(spam[,1:5])
set.seed(3435)
trainIndicator <- rbinom(4601,size = 1,prob = 0.5) 
table(trainIndicator)
trainSpam <- spam[trainIndicator == 1,]
testSpam <- spam[trainIndicator == 0,]
names(trainSpam)
head(trainSpam)
table(trainSpam$type)
with(trainSpam,plot(capitalAve ~ type))
with(trainSpam,plot(log10(capitalAve+1) ~ type))
plot(log10(trainSpam[,1:4]+1))

hCluster = hclust(dist(t(trainSpam[,1:57])))
plot(hCluster)


hClusterUpdated = hclust(dist(t(log10(trainSpam[,1:57]+1))))
plot(hClusterUpdated)

trainSpam$numType = as.numeric(trainSpam$type)-1
costFunction = function(x,y) sum(x != (y>0.5))
cvError <- rep(NA,55)

library(boot)

for (i in 1:55) {
  lmFormula = reformulate(names(trainSpam)[i], response = "numType")
  glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
  cvError[i] = cv.glm(trainSpam,glmFit,costFunction,2)$delta[2] 
}

names(trainSpam)[which.min(cvError)]

predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)

predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonSpam",dim(testSpam)[1])

predictedSpam[predictionModel$fitted > 0.5] = "spam"

table(predictedSpam,testSpam$type)
