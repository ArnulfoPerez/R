nx=8
ny=8
sx2=3
sy2=5
sp = sqrt((sx2/nx)+(sy2/ny))
df = ((sx2/nx)+(sy2/ny))^2/((sx2/nx)^2/(nx-1)+(sy2/ny)^2/(ny-1))
df
x=2
ci = x+c(-1,1)*qt(.95,14)
ci

m=1100
s=30
n = 9
df = n-1
ci = m+c(-1,1)*qt(.975,df)*s/sqrt(n)
ci

n <- 9
df <- n-1
m = -2
sd <- 2 * sqrt(n) / qt(.975,df)
sd
ci = m+c(-1,1)*qt(.975,df)*sd/sqrt(n)
ci

old.mean <- 5
old.var <- 0.68
old.n <- 10

new.mean <- 3
new.var <- 0.60
new.n <- 10

alpha <- (1 - .95)
df <-  old.n + new.n - 2

t <- qt(1 - alpha / 2,df)

sp <- sqrt(((old.n - 1) * old.var + (new.n - 1) * new.var) / (old.n + new.n - 2))

(new.mean - old.mean) + c(-1, 1) * t * sp * sqrt(1 / old.n + 1 / new.n)



x <- seq(0, 1, length = 21)
dbeta(x, 1, 1)
pbeta(x, 1, 1)

## Visualization, including limit cases:
pl.beta <- function(a,b, asp = if(isLim) 1, ylim = if(isLim) c(0,1.1)) {
  if(isLim <- a == 0 || b == 0 || a == Inf || b == Inf) {
    eps <- 1e-10
    x <- c(0, eps, (1:7)/16, 1/2+c(-eps,0,eps), (9:15)/16, 1-eps, 1)
  } else {
    x <- seq(0, 1, length = 1025)
  }
  fx <- cbind(dbeta(x, a,b), pbeta(x, a,b), qbeta(x, a,b))
  f <- fx; f[fx == Inf] <- 1e100
  matplot(x, f, ylab="", type="l", ylim=ylim, asp=asp,
          main = sprintf("[dpq]beta(x, a=%g, b=%g)", a,b))
  abline(0,1,     col="gray", lty=3)
  abline(h = 0:1, col="gray", lty=3)
  legend("top", paste0(c("d","p","q"), "beta(x, a,b)"),
         col=1:3, lty=1:3, bty = "n")
  invisible(cbind(x, fx))
}
pl.beta(3,1)

pl.beta(2, 4)
pl.beta(3, 7)
pl.beta(3, 7, asp=1)

pl.beta(0, 0)   ## point masses at  {0, 1}

pl.beta(0, 2)   ## point mass at 0 ; the same as
pl.beta(1, Inf)

pl.beta(Inf, 2) ## point mass at 1 ; the same as
pl.beta(3, 0)

pl.beta(Inf, Inf)# point mass at 1/2

x <-4
n <- 10
a <- 10
b <- 10

(x+a)/(n+a+b)

pbeta(.4,10,10)
dbeta(.43,.5,.5)

