#Assignment 6
#6.1
A=matrix(c(2,0,1,3), ncol=2) 
B=matrix(c(5,2,4,-1), ncol=2)
#1a find A+B
C=A+B
C
#1b find A-B
D=A-B
D
#6.2
x <- c(4,1,2,3)
diag(x)
#6.3
mymatrix <- diag(3, nrow=5)
mymatrix[1,(2:5)] = 1
mymatrix[(2:5),1] = 2
mymatrix