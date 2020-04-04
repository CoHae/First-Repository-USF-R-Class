tukey_multiple <- function(x) {
  outliers <- array(TRUE,dim=dim(x))
  
  # find number of rows  
  y <- nrow(x)
  
  for (j in 1:ncol(x))
  {
    
    # tukey.outlier has to go over all rows of column j 
    # original. Gives error "could not find function "tukey.outlier" " ------------   
    #  outliers[,j] <- outliers[,j] && tukey.outlier(x[,j])
    # ---------------------------------------------------------------------------    
    outliers[,j] <- outliers[,j] && tukey.outlier[,j]
    #    outliers[,j] <- outliers[,j] && tukey.outlier[(1:y),j]
  }
  
  for (i in 1:nrow(x))
  { outliers.vec[i] <- all(outliers[i,]) } 
  
  return(outliers.vec) }

column1 <- c(2,3,4)
column2 <- c(5,6,7)
column3 <- c(7,8,9)
column4 <- c(1,2,3)
x <- data.frame(column1, column2, column3, column4)

tukey1 <- c(FALSE,FALSE, TRUE, TRUE, TRUE)
tukey2 <- c(FALSE,TRUE, TRUE, FALSE, FALSE)
tukey3 <- c(FALSE,TRUE, TRUE, TRUE, FALSE)
tukey4 <- c(TRUE,FALSE, TRUE, FALSE, TRUE)
tukey5 <- c(FALSE,TRUE, TRUE, FALSE, FALSE)
tukey.outlier <- data.frame(tukey1, tukey2, tukey3, tukey4, tukey5)

thisfunction <- tukey_multiple(x)
thisfunction