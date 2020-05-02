library(rgl)
library(mvtnorm)

sigma <- matrix(c(8, 0.25*8, 0.25*8, 8), 2, 2)
xvals <- seq(-10, 10, length = 100)
yvals <- seq(-10, 10, length = 100)
zvals <- apply(expand.grid(xvals,yvals), 1, 
               function(w) dmvnorm(w, mean = c(0,0), sigma = sigma))
persp3d(x = xvals, y = yvals, z = zvals, col = "lightblue")
planes3d(0,1,0,-5,col = grey(.8))