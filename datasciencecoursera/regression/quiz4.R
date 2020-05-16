library(MASS)
library(dplyr)
shuttle2 <- mutate(shuttle,auto=1*(use=="auto"))
head(shuttle)
head(shuttle2)
logreg1 <- glm(auto~factor(wind)-1,family = binomial(link="logit"),data=shuttle2)
summary(logreg1)$coef
Coeffs <- summary(logreg1)$coef
Coeffs
exp( Coeffs[1,1]-Coeffs[2,1])

logreg2 <- glm(auto~factor(wind)+factor(magn)-1,family = binomial(link="logit"),data=shuttle2)
summary(logreg2)$coef

Coeffs2 <- summary(logreg2)$coef
exp(Coeffs2[1,1]-Coeffs2[2,1])

logreg3 <- glm(auto~factor(wind),family = binomial(link="logit"),data=shuttle2)
summary(logreg3)$coef

logreg4 <- glm(1-auto~factor(wind),family = binomial(link="logit"),data=shuttle2)
summary(logreg4)$coef

pois <- glm(count~factor(spray)-1,family = poisson(link="log"),data=InsectSprays)
Coeffs3 <- summary(pois)$coef
Coeffs3
exp(Coeffs3[1,1]-Coeffs3[2,1])

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)


plot(x,y)
lm1 <- lm(y[1:6]~x[1:6])
lm2 <- lm(y[6:11]~x[6:11])

summary(lm2)

abline(lm1,col="blue",lw=2)
abline(lm2,col="blue",lw=2)

knot <- c(0)
splineterm <- sapply(knot,function(knot) ((x>knot)*(x-knot)))
mat <- cbind(1,x,splineterm)
linreg6 <- lm(y~mat-1)
pred6 <- predict(linreg6)
lines(x,pred6,col="red")
legend(x=-1,y=5, c("With lm","With X"),lty=c(1,1), lwd=c(2.5,2.5),col=c("blue", "red"))

slope = (pred6[11]-pred6[6])/(x[11]-x[6])
slope