make.power <- function(n){
  function(x){ x^n}
}
cube <-make.power(3)
square <-make.power(2)
ls(environment(cube))
ls(environment(square))
get("n",environment(cube))
get("n",environment(square))

f <- function(x){
  g <- function(y){
    y + z
  }
  z <- 4
  x + g(x)
}

z <- 10
f(3)