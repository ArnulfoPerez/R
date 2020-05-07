set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,2)]=NA

library(plyr)
arrange(X,var1)
arrange(X,desc(var1))
X$var4 = rnorm(5)
Y <- cbind(X,rnorm(5))
