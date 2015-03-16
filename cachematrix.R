## Matrix inversion is usually a costly computation. So the inverse of a matrix is usually been cached reather than being computed repeatedly for futher use. The following two functions are performed to cache the inverse of a matrix.

## This function creates a special "matrix" that can cache its inverse. It returns a list of functions including: set the value of the matrix; get the value of the matrix; set the value of the inverse of the matrix, get the value of the inverse of the matrix.
makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL##initializes variable"inv", clearing any old values.
        set <- function(y){##
                x <<- y ##set"x" to "y" within the whole "makeCacheMatrix"function, not just the "set" subfunction. "y" is the new vector.
                inv <<- NULL ## inverse is reset to NULL
        }
        get <- function() x
        setinverse <- function(inverse) inv<<-inverse
        getinverse <- function() inv
        list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}

## This function computes the inverse the matrix. It will first check if the inverse has already been calculated. if so, the cachesolve will retrieve the inverse from the cache. If not, it will compute the inverse, and sets the value in the cache by using setinverse function.

cacheSolve <- function(x, ...) {
        inv<-x$getinverse()
        if(!is.null(inv)){
                message("getting cached inverse matrix")
                return(inv)       
        }
        data<-x$get()
        inv<-solve(data,...)
        x$setinverse(inv)
        inv## Return a matrix that is the inverse of 'x'
}

##Test
##m<-makeCacheMatrix(matrix(1:4,2,2))
##m$get()
##No cache in the first run
##cacheSolve(m)
##Retrieving from the cache in the second run (see the message"getting cached inverse matrix")
##cacheSolve(m)



