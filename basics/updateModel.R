set.seed(345)
df <- data.frame(x = rnorm(20))
df <- transform(df, y = 5 + (2.3 * x) + rnorm(20))
## model
m1 <- lm(y ~ x, data = df)
## save this model
save(m1, file = "my_model1.rda")
 
## a month later, new observations are available: 
newdf <- data.frame(x = rnorm(20))
## load the model
load("my_model1.rda")
## predict for the new `x`s in `newdf`
predict(m1, newdata = newdf)

# If wanting to automate this, then I would probably do the following in a script:
  
## data
df <- data.frame(x = rnorm(20))
df <- transform(df, y = 5 + (2.3 * x) + rnorm(20))

## check if model exists? If not, refit:
if(file.exists("my_model1.rda")) {
  ## load model
  load("my_model1.rda")
} else {
  ## (re)fit the model
  m1 <- lm(y ~ x, data = df)
}

## predict for new observations
## new observations
newdf <- data.frame(x = rnorm(20))
## predict
predict(m1, newdata = newdf)

#using update


set.seed(123)
df <- data.frame(x = rnorm(20))
df <- transform(df, y = 5 + (2.3 * x) + rnorm(20))
## model
m1 <- lm(y ~ x, data = df)
 
## new observations
newdf <- data.frame(x = rnorm(20))
newdf <- transform(newdf, y = 5 + (2.3 * x) + rnorm(20))
## add on to df
df <- rbind(df, newdf)
 
## update model fit
m2 <- update(m1, . ~ ., data = df)
m2
