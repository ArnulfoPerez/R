## This function create an special "matrix" object
## that can cache its invers

## The function creates a local environment to cache
## the inverse of a matrix in its closure

makeCacheMatrix <- function(x = matrix()) {
  cache <-NULL
  list(set = function(y){
                          x <<- y
                          cache <<- NULL},
       get = function(){x},
       setInverse = function(inverse){
                          cache <<- inverse
       },
       getInverse = function(){cache})

}


## this function computes the inverse of a matrix object
## created by makeCacheMatrix

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  inverse <- x$getinverse
  if(is.null(inverse)) {
    inverse <- x$setInverse(solve(x$get()))
  }
  inverse
}
