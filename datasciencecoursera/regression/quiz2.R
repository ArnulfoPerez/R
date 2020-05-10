x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

summary(lm(y ~ x))

data("mtcars")



fit <- lm(mpg ~ wt, data=mtcars)

newdata <- data.frame(wt=mean(mtcars$wt))
predict(fit, newdata, interval=("confidence"))

newdata <- data.frame(wt=3000/1000)
predict(fit, newdata, interval=("prediction"))

mtcars$wt_ton <- mtcars$wt / 2
fit <- lm(mpg ~ wt_ton, data=mtcars)
(coef <- summary(fit)$coeff)

coef[2,1] + c(-1, 1) * qt(.975, df=fit$df) * coef[2,2]

fit_num <- lm(mpg ~ wt, data=mtcars)
fit_denom <- lm(mpg ~ 1 + offset(0 * wt), data=mtcars)
sum(resid(fit_num)^2) / sum(resid(fit_denom)^2)