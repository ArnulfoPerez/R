
library(UsingR)
library(ggplot2)
data(galton)

lm(I(child - mean(child)) ~ I(parent - mean(parent)) -1, data = galton)

y <- galton$child
x <- galton$parent

β1 <- cor(y,x) * sd(y)/sd(x)
β0 <- mean(y) - β1 * mean(x)
rbind(c(β0,β1),coef(lm(y ~ x)))
