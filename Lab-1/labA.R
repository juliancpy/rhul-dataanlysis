#We use set.seed() throughout the labs whenever we perform calculations involving
# random quantities.
set.seed(3)
#We create a random matrix.
y <- rnorm(100)
#we can get de mean of the matrix with mean()
mean(y)
# var() is to get the variance.
var(y)
# if we need de standart desviation we can use sd() or calculate sqrt of the variance
sqrt(var(y))
sd(y)

# 3 Graphics
# we clean the global envirnment.
rm(list = ls())
x <- rnorm(100)
y <- rnorm(100)
plot(x,y, xlab="this is the x-axis", ylab="this is the y-axis", main = "Plot of X vs Y")
#We can define the folder where we are working. using getwd and setwd
#setwd("/Users/jcaceres/Documents/RHUL/CS4100:CS5100 DataAnalysis/rhul-dataanlysis/Lab-1")
# We will often want to save the output fo an R plot.
pdf("Figure.pdf")
plot(x,y,col="green", xlab="this is the x-axis", ylab="this is the y-axis", main = "Plot of X vs Y")
dev.off()
# Function seq(). sequence of numbers.
a <- seq(1,10)
a <- 1:10
# The following function plots the graph of the function sin over the interval
# [-pi;pi]:
x <- seq(-pi, pi, length=50)
x
plot(x, sin(x))

# 4 Indexing Data.
A <- matrix(1:16,4,4)
A
A[2,3]
# We can also select multiple rows and columns at a time, by providing vectors as the indices.
# c(1,3) are the rows and c(2,4) are the columns
A[c(1,3),c(2,4)]
# rows=1,2,3 cols=2,3,4
A[1:3,2:4]
# rows=1,2 cols=all
A[1:2,]
# rows=all cols=1,2
A[,1:2]
# cols=all row=1
A[1,]
# all row or col except those indicated with the sign - (negative)
# row=2,4 cols=all
A[-c(1,3),]

#dim is a function to get the number of row and col 
dim(A)

# 5 Loading Data. 
#getwd()
#setwd()
# set dataframe
Auto <- read.table("Auto.data")
# tells R that the first line of the file contains the variables of names.
# na.strings tells R that any time it sees a particular character or set of characters, it
# should be treated as a missing element of the data matirx.
Auto <- read.table("Auto.data", header=T, na.strings = "?")
# dim tell us that the data has 397 obs. or rows and 9 var or colums
# na.omit() remove rows containing missing observations.
Auto <- na.omit(Auto)
dim(Auto)
#check variable names
names(Auto)

# Additional Graphical and Numerical Summaries.
plot(Auto$cylinders,Auto$mpg)
# attach order to R to make the variables in this data frame available by name
attach(Auto)
plot(cylinders,mpg)
# some variable are only small number and we need to treat it as qualitative no quantitave.
cylinders <- as.factor(cylinders)
plot(cylinders, mpg)
plot(cylinders, mpg, col="red")
plot(cylinders, mpg, col="red", varwidth=T)
plot(cylinders, mpg, col="red", varwidth=T, horizontal=T)
plot(cylinders, mpg, col="red", varwidth=T, xlab="cylinders", ylab="MPG")
# plot some histogram
hist(mpg)
hist(mpg, col=2)
hist(mpg, col=2, breaks = 15)
# This function create a scatterplot matirx for every pair of variable for any given data set.
pairs(Auto)
pairs(~ mpg + displacement + horsepower + weight + acceleration, Auto)
plot(horsepower, mpg)
# 
identify(horsepower, mpg, name)
summary(Auto)
#For qualitative variables such as name, R will list the number of observations
#that fall in each category. We can also produce a summary of just a single
#variable.
summary(mpg)
?range
range(mpg)
