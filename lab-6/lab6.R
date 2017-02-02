rec <- function(x) (abs(x) < 1) * 0.5
tri <- function(x) (abs(x) < 1) * (1 - abs(x))
gauss <- function(x) 1/sqrt(2*pi) * exp(-(x^2)/2)
x <- seq(from = -3, to = 3, by = 0.001)
plot(x, rec(x), type = "l", ylim = c(0,1), lty = 1,ylab = expression(K(x)))
lines(x, tri(x), lty = 2)
lines(x, gauss(x), lty = 3)
legend(-3, 0.8, legend = c("Rectangular", "Triangular", "Gaussian"),lty = 1:3, title = "kernel functions", bty = "n")

#   sapply() applies a function to elements in a list and returns the results
#   in a vector, matrix, or list,
#   apply() applies a function to rows or columns of a matrix (more generally,
#                                                              to dimensions of an array),
#   rowSums() sums up the rows of a matrix (this function is a computation-
#                                             ally ecient special case of apply),
#   rug() creates a set of tick marks along the base of a plot.

x <- c(0, 1, 1.1, 1.5, 1.9, 2.8, 2.9, 3.5)
n <- length(x)
xgrid <- seq(from=min(x)-1, to=max(x)+1, by=0.01)
h <- 0.4
bumps <- sapply(x, function(a) gauss((xgrid-a)/h)/(n*h))
plot(xgrid, rowSums(bumps), ylab=expression(hat(f)(x)),
     type = "l", xlab = "x", lwd = 2)
rug(x, lwd=2)
out <- apply(bumps, 2, function(b) lines(xgrid, b))


#K-means clustering
set.seed(2)
x <- matrix(rnorm(50*2),ncol=2)
x[1:25,1] <- x[1:25,1]+3
x[1:25,2] <- x[1:25,2]-4

km.out <- kmeans(x, 2, nstart=20)
km.out$cluster


plot(x, col=(km.out$cluster+1), main="K-Means Clustering Results
with K=2", xlab="", ylab="", pch=20, cex=2)

set.seed(4)
km.out <- kmeans(x, 3, nstart=20)
km.out

set.seed(3)
km.out <- kmeans(x, 3, nstart=1)
km.out$tot.withins
km.out <- kmeans(x, 3, nstart=20)
km.out$tot.withinss







#Ex.. 1
x <- c(0, 1, 1.1, 1.5, 1.9, 2.8, 2.9, 3.5)
n <- length(x)
xgrid <- seq(from=min(x)-1, to=max(x)+1, by=0.01)
#h <- 0.6
h <- 0.5

bumps <- sapply(x, function(a) gauss((xgrid-a)/h)/(n*h))
plot(xgrid, rowSums(bumps), ylab=expression(hat(f)(x)),
     type = "l", xlab = "x", lwd = 2)
rug(x, lwd=2)
out <- apply(bumps, 2, function(b) lines(xgrid, b))

# Ex.. 2

set.seed(2)
x <- matrix(rnorm(60*2),ncol=2)
x[1:20,1] <- x[1:20,1]+3
x[1:20,2] <- x[1:20,2]-4
x[1:20,3] <- x[1:20,3]-4

km.out <- kmeans(x, 2, nstart=20)
km.out$cluster

