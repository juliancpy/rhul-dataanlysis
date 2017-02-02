LoadLIbraries <- function(){
  library(ISLR)
  library(MASS)
  print("The libraries have been loaded.")
}
LoadLIbraries()
curve(x*sin(x^2),-3,3)

x <- seq(-3,3,0.01)
y <- x*sin(x^2)
plot(x,y,type="l")

# Loops et al.
for (i in 1:4) print(i^2)

#5 Normalization in R
#This section discusses the K-Nearest Neighbours algorithm and logistic regres-
#  sion in a realistic scenario with pre-processing of data
dim(Caravan)
attach(Caravan)
summary(Purchase)
348/5822

standarized.X <- scale(Caravan[,-86])
var(Caravan[,1])
var(Caravan[,2])
var(standarized.X[,1])
var(standarized.X[,2])
test <- 1:1000
train.X <- standarized.X[-test,]
test.X <- standarized.X[test,]
train.Y <- Purchase[-test]
test.Y <- Purchase[test]

library(class)
set.seed(1)
knn.pred <- knn(train.X, test.X, train.Y,k=1)
mean(test.Y!=knn.pred)
mean(test.Y!="No")
table(knn.pred, test.Y)
