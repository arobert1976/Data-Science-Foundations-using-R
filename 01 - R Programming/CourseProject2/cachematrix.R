## Matrix inversion is usually a costly computation and there may be some benefit to caching 
## the inverse of a matrix rather than computing it repeatedly. 
## These 2 functions below allow to get the inverse of the matrix 
## from the cache if it has already been calculated.

## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    
    set <- function(y){
        x <<- y
        inv <<- NULL
    }
    
    get <- function(){
        x    
    }
    
    setinv <- function(inversematrix){
        inv <<- inversematrix
    }
    
    getinv <- function(){
        inv
    }
    
    list(set=set, get=get, setinv=setinv, getinv=getinv)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
    inv <- x$getinv()
    if(!is.null(inv)){
        message("getting the inverse of the matrix from the cache")
        return(inv)
    }
    
    ## Otherwise, calculate the inverse of the matrix and set/store it in the cache.
    matrix <- x$get()
    inv <- solve(matrix)
    x$setinv(inv)
    inv    
}