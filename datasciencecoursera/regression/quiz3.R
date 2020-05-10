data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
summary(fit)$coefficient

fit2 <- lm(mpg ~ factor(cyl), data = mtcars)
summary(fit2)$coefficient

summary(fit)$coef[3]
summary(fit2)$coef[3]

fit_inter <- lm(mpg ~ factor(cyl) * wt, data = mtcars)
anova(fit, fit_inter, test = "Chisq")

lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit5 <- lm(y ~ x)
hatvalues(fit5)

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit6 <- lm(y ~ x)
dfbetas(fit6)[, 2]