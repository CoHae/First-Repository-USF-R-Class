#Assignment 8 STEP1
install.packages("pryr")
require(pryr)
require(ISLR)
require(boot)
install.packages("plyr")
library(data.table)
library(plyr)
# after downloading I copied the dataset into my working directory.
# I use getwd() to find out what my working directory is
getwd()
#The following works but doesn't prompt the user
#FileName <- "Assignment 6 Dataset"
# read.table("<FileName>.txt", header = TRUE, sep = ",")
  
# prompt the user
filename <- readline("What is the input file name? ")
# I added the sep = "," parameter to make the comma delimited input 
# file into separated columns instead of one long character string
Student <- read.table(filename, header = TRUE, sep = ",")

library(dplyr)

StudentAverage = ddply(Student,"Sex",transform,Grade.Average=mean(Grade))
StudentAverage

tapply(Student$Grade, Student$Sex, mean)

sumdata <- ddply(Student,"Sex",summarize,Mean = mean(Grade))
sumdata

#Assignment 8 STEP2: create sub-dataset which contains i in Name.
#ignore.case makes sure lower case and upper case "i"s will be found
# Then write comma delimited (sep = ",") subset to a file
i_Student <- subset(Student, grepl("i", Student$Name, ignore.case=T))
# as requested create dataframe
i_Names_df <- as.data.frame(i_Student)
i_Names_df
#create new data set with names only
inames <- as.vector(i_Names_df['Name'])
inames
#write names to file.I don't prompt the user here (I do that in Step3)
# I wanted to use write.csv because the file is supposed to be comma
# delimited (csv means "comma separated values"). But I always get "x"
# in line 1. I know the x comes from the column name but write.cvs
# ignores col.names = FALSE, comes back with "attempt to set 'col.names' 
# ignored". That's why I use write.table instead and set sep = ","
# col.names = FALSE is necessary. Otherwise the first row is dispalyed 
# as "x"
#write.csv(inames, file = "inames.csv", quote = FALSE, row.names = FALSE)
write.table(inames, file = "inames.csv", append = FALSE, quote = FALSE, 
            row.names = FALSE, col.names = FALSE, sep = ",")


#         
#Step 3
# Write to a file in csv format. It will write into the working directory
# this first commented out version didn't prompt the user
#append = FALSE makes sure file gets overwritten each time instead of 
#appended
#quote = FALSE. If quote = TRUE all character variables will be enclosed
# in quotes
#write.table(i_Student, file = "iSubsetWithMeans", 
#            append = FALSE, quote = FALSE, sep = ",")

#this prompts the user.Even though new=TRUE it looks like you can only
# choose from existing files when writing into that file.
write.csv(i_Student,file.choose(new=TRUE),append = FALSE, 
          quote = FALSE)
