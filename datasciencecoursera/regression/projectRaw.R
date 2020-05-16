data("mtcars")
head(mtcars)
summary(mtcars)
str(mtcars)
lm(mpg ~ ., data = mtcars)

mcars <- mtcars[mtcars$am==1,]
acars <- mtcars[mtcars$am==0,]
summary(mcars)[,c(1,6)]
summary(acars)[,c(1,6)]
lmw <- lm(mpg ~ wt, data = mtcars)


lma <- lm(mpg ~ wt, data = acars)
lmm <- lm(mpg ~ wt, data = mcars)
plot(mtcars$wt,mtcars$mpg,col=mtcars$am+1)
legend('topright', legend = levels(factor(mtcars$am)), col = 1:2, cex = 0.8, pch = 1)
abline(lm(mpg ~ wt, data = mtcars))
abline(lmm,col="red",lw=2)
abline(lma,col="blue",lw=2)

fit_final <- lm(mpg ~ ., data = mtcars);
par(mfrow = c(2, 2))
plot(fit_final)
dev.off()
ncars <- mtcars[mtcars$mpg < 31 & mtcars$wt<5 & mtcars$wt > 3,]
mncars <- ncars[ncars$am==1,]
ancars <- ncars[mtcars$am==0,]
summary(mncars)[,c(1,6)]
summary(ancars)[,c(1,6)]
lmn <- lm(mpg ~ wt, data = ncars)
lmna <- lm(mpg ~ wt, data = ancars)
lmnm <- lm(mpg ~ wt, data = mncars)
plot(ncars$wt,ncars$mpg,col=ncars$am+1)
legend('topright', legend = levels(factor(mtcars$am)), col = 1:2, cex = 0.8, pch = 1)
abline(lmn,lw=2)
abline(lmnm,col="red",lw=2)
abline(lmna,col="blue",lw=2)

set.seed(2)
plot(0:10, rnorm(11), col = sample(c("green", "blue"), 11, replace = TRUE), 
     pch = sample(c(3, 19), 11, replace = TRUE), xlim = c(0, 12))
legend("topright", pch = c(3, 19, NA, 3, 19), 
       col = c("green", "green", NA, "blue", "blue"), 
       legend = c("green cross", "green dot", NA, "blue cross", "blue dot"))


test <- structure(list(x = c(0, 9, 27, 40, 52, 59, 76), y = c(50, 68, 
                                                              79, 186, 175, 271, 281)), .Names = c("x", "y"))

# set up an example plot
plot(test,pch=19,ylim=c(0,300),
     panel.first=abline(h=c(0,50),v=c(0,10),lty=3,col="gray"))

# standard line of best fit - black line
abline(lm(y ~ x, data=test))

# force through [0,0] - blue line
abline(lm(y ~ x + 0, data=test), col="blue")