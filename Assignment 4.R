Freq <- c(0.6,0.3,0.4,0.4,0.2,0.6,0.3,0.4,0.9,0.3)
bloodp <- c(103,87,32,42,59,109,78,205,135,176)
first <- c(1,1,1,1,0,0,0,0,NA,1)
second <-c(0,0,1,1,0,0,1,1,1,1)
finaldecision <-c(0,1,0,1,0,1,0,1,1,1)
# boxplot(Freq,bloodp)# won'tuse bc scale of Freq and bloodp is vastly different

# parameter to display 2 graphs, arranged in 1 rows and 2 columns
par(mfrow=c(2,2))
#
boxplot(Freq, main="Boxplot of Frequency")
hist(Freq, main="Histogram of Frequency") 
boxplot(bloodp, main="Boxplot of Blood Pressure")
hist(bloodp, main="Histogram of Blood Pressure")
windows()
par(mfrow=c(3,1))
barplot(first, main="Bargraph of First Assessment by Patient")
barplot(second, main="Bargraph of Second Assessment by Patient")
barplot(finaldecision, main="Bargraph of Final Decision by Patient")