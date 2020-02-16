# In order for a matrix to be invertible (not to be confused with transposable!)
# it has to be 
# 1.) square and 2.) not singular, meaning the determinant cannot be 0.
# Neither one of the two matrices given is invertible 
# Matrix B obviously is not square (10 rows, 100 columns)
# Matrix A, while square, has a determinant of 0

A <- matrix(1:100, nrow=10)  
B <- matrix(1:1000, nrow=10)
solve(A)
solve(B)
det(A)
det(B)
# a matrix like the following (square with random integer values) is invertible 
# with a very high probability
mymatrix <- matrix(sample.int(50), nrow = 5, ncol = 5)
mymatrix
det(mymatrix)
solve(mymatrix)