# First-Repository-USF-R-Class

# original/faulty Assignment 2
# it shows that neither "assignment" nor "someData" exist
assignment2 <- c(16, 18, 14, 22, 27, 17, 19, 17, 17, 22, 20, 22)
myMean <- function(assignment2) { return(sum(assignment)/length(someData)) }
myMean(assignment2)
someData
# corrected code for Assignment 2
assignment2 <- c(16, 18, 14, 22, 27, 17, 19, 17, 17, 22, 20, 22)
myMean <- function(assignment2) { return(sum(assignment2)/length(assignment2)) }
myMean(assignment2)

# Assignment 3
# original/faulty Assignment 3
#Name <- c("Jeb", “Donald”, "Ted”, “Marco” “Carly”, “Hillary”, “Berine”)
#ABC political poll results <- c(4, 62 51, 21, 2, 14, 15)
#CBS political poll results <- c(12, 75, 43, 19, 1, 21, 19) 

# commas missing and not allowed spaces in vector names leads to the error messages
# Error: unexpected input in Name <- c("Jeb", “"
# Error: unexpected symbol in "CBS political"

# corrected code for Assignment 3
Name <- c("Jeb", "Donald", "Ted", "Marco", "Carly", "Hillary", "Bernie")
ABC_political_poll_results <- c(4, 62, 51, 21, 2, 14, 15)
CBS_political_poll_results <- c(12, 75, 43, 19, 1, 21, 19) 
Name
ABC_political_poll_results
CBS_political_poll_results

#To make these vectors into a data frame use
Presidential_Election <- data.frame(Name, ABC_political_poll_results,CBS_political_poll_results)
Presidential_Election