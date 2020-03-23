#Assignment 9
# 3 "types" of graphs for dataset "Survival from Malignant Melanoma"
# the 3 types being: 1) a basic" R graph without any package, 
# 2) a "Lattice" graph
# 3) a "ggplot2" graph
# install packages readxl and Rcpp to import dataset "Melanoma"
if(!require(readxl)){install.packages("readxl")}
if(!require(Rcpp)){install.packages("Rcpp")}
if(!require(grid)){install.packages("grid")}
if(!require(gridExtra)){install.packages("gridExtra")}
if(!require(ggplotify)){install.packages("ggplotify")}
if(!require(base2grob)){install.packages("base2grob")}
if(!require(lattice)){install.packages("lattice")}
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(base2grob)){install.packages("base2grob")}

library(readxl)
library(Rcpp)
library(grid)
library(gridExtra)
library(ggplotify)
library("base2grob")
library(lattice)
library(ggplot2)
library(base2grob)
# Import Dataset "Melanoma" in "Environment". Upload into R from previously downloaded dataset

# display all 3 graphs on the same page (in 2 rows)
#par(mfrow...) DOES NOT WORK FOR LATTICE GRAPHS! USE package gridExtra (see below) but all graphs
# used need to be a grob. Basic graphs need to be converted to a grob using "base2grob", others
# "as.grob"
#par(mfrow=c(2,2))

#Graph 1: basic R. I chose to create a pie chart of survival length (groups of length of survival)

# group VLXT for grouped histogram and pie chart
melanoma$groupedtime <- cut(melanoma$time,c(-Inf, 364, 1824, Inf),
                              labels=c("less than 1 year", 
                                       "1 year to less than 5 years", 
                                       ">5 years"))
# to make pie chart: create 2 vectors with labels/group names and count occurances 
# that fall into those groups

groups <- "less than 1 year"
numberofoccurances <- sum(melanoma$groupedtime == "less than 1 year")
groups <- c(groups,  "1 year to less than 5 years")
numberofoccurances <- c(numberofoccurances, 
                        sum(melanoma$groupedtime == "1 year to less than 5 years"))
groups <- c(groups, ">5 years")
groups
numberofoccurances <- c(numberofoccurances, 
                        sum(melanoma$groupedtime == ">5 years"))

plot1 <- base2grob(~pie(numberofoccurances, labels = groups, main = "Melanoma Survival Time"))

#Graph 2: a lattice graph. I make a relative frequency graph using lattice/histogram
plot2 <- as.grob(histogram(melanoma$time, 
                           xlab = "Days",
                           main = "Rel. Frequency of Melanoma Survival Time"))

#Graph 3: a ggplot2 graph. I produce a scatterplot
plot3 <- as.grob(ggplot(melanoma, aes(x=age, y=time)) + geom_point()
                 + labs(title="Melanoma Survival Time and Age", x="Age", y="Time (in Days)"))

grid.arrange(plot1, plot2, plot3, nrow = 2)