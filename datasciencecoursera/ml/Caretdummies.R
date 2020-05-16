library(earth)
data(etitanic)
head(model.matrix(survived ~ ., data = etitanic))

dummies <- dummyVars(survived ~ ., data = etitanic)
head(predict(dummies, newdata = etitanic))