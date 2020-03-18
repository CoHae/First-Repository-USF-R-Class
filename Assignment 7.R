# I imported a subset of my Tetratricoptide Repeat Proteins data

# Q: can generic functions be assigned to your dataset?
# Yes, generic functions like "print" and "summary" can be assigned to 
# my dataset

print(mydata)
summary(mydata)

# test if my dataset is a S3 or S4 object. 
# S3 if "is.object" is true and "NOT isS4" is also true
is.object(mydata) & !isS4(mydata)

# or: Install - if necessary - pryr and load it. otype gives you back 
# the object type 
if(!require(pryr)){install.packages("pryr")}
library(pryr)
otype(mydata)

#determine base type
typeof(mydata)

#create an S3 object
mys3A <- list(genename = "G1", length = 102, disease =T)
mys3A
mys3B <- list(genename = "G2", length = 250, disease =F)
mys3B

#create an S4 object
#First - create a new class 
setClass("gene", representation(genename="character", 
                        length="numeric",disease="logical"))                             
mys4A <- new("gene", genename="G1", length=102, disease =T)
mys4A
mys4B <- new("gene", genename="G2", length=250, disease =F)
mys4B
