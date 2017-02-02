# The library() function is used to load libraries (groups of fuctions and data sets).
getwd()

library(tree)
library(ISLR)
data("Carseats")
names(Carseats)
attach(Carseats)
head(Carseats)
# We use the ifelse() function to create a variable, called
# High, which takes on a value of Yes if the Sales variable exceeds 8, and takes
# on a value of No otherwise.
range(Sales)
# categorical variable High, to help us.
High <- ifelse(Sales<=8,"No","Yes")

#Finally, we use the data.frame() function to merge High with
#the rest of the Carseats data.
Carseats <- data.frame(Carseats, High)
Carseats = Carseats[,-1]
#If we want we can remove Sales from our datasets.
# Carseats <- Carseats[, -1]
# We now use the three() 
rm(list = ls())
tree.carseats <- tree(High~.,Carseats)
# The dot . refers to the set of all variables in the data frame apart from the
# variable we are predicting. We have removed Sales using the -Sales syntax.
summary(tree.carseats)
# error rate 9%
plot(tree.carseats)
text(tree.carseats, pretty=0)
tree.carseats
set.seed(2)
train <- sample(1:nrow(Carseats),nrow(Carseats)/2)
test = -train
training_data = Carseats[train, ]
testing_data = Carseats[test, ]
testing_high = High[test]
# We then build the tree using the training set, and evaluate its performance on the test data.
tree_model = tree(High~., training_data)
plot(tree_model)
text(tree_model, pretty = 0)
# The other way or an other option.
# tree.carseats <- tree(High~.-Sales, Carseats, subset = train)
# The predict() functin can bu used for this purpose.
tree_pred = predict(tree_model, testing_data, type = "class")
table(tree_pred, testing_high)
mean(tree_pred != testing_high)
# Other way is:
set.seed(2)
train <- sample(1:nrow(Carseats),nrow(Carseats)/2)
Carseats.test <- Carseats[-train, ]
tree.carseats <- tree(High~., Carseats, subset = train)
tree.pred <- predict(tree.carseats, Carseats.test, type = "class")
High.test <- High[-train]
table(tree.pred, High.test)
#         High.test
#tree.pred  No   Yes
#       No  86   27
#       Yes 30   57
#
(86 + 57)/200
# This approach leads to correct predictions for around 71.5% of the locations in the test data set.

# Pruning
# Cross validation to check wher to stop pruning
set.seed(3)
cv.carseats <- cv.tree(tree.carseats, FUN=prune.misclass)
names(cv.carseats)
cv.carseats

# Plot the error rate as a function of both size and k
attach(cv.carseats)
# if we want to see several plots together we can use the par() functin
par (mfrow=c(1,2))
plot(cv.carseats$size, cv.carseats$dev, type = "b" )
plot(cv.carseats$k, cv.carseats$dev, type = "b" )

prune.carseats <- prune.misclass(tree.carseats, best=9)
plot(prune.carseats)
text(prune.carseats, pretty = 0)

pred_pron = predict(prune.carseats, Carseats.test, type = "class")
table(pred_pron, High.test)
(94 + 60)/200 
# This approach leads to correct predictions for around 77% of the locations in the test data set.
# Now 77% of the test observations are correctly classified, so not only has the pruning process
# produced a more interpretable tree.
mean(pred_pron != High.test) # 23%

# If we increase th evalue of best, we obtain a larger pruned tree with lower classificatino accurancy

prune.carseats <- prune.misclass(tree.carseats, best=15)
plot(prune.carseats)
text(prune.carseats, pretty = 0)

pred_pron = predict(prune.carseats, Carseats.test, type = "class")
table(pred_pron, High.test)
(86+62)/200
# Now 74% of the test observations are correctly classified,


# Fitting Regression Trees.
# In this section we fit a regression tree to the Boston data set (part of the massive
# MASS library,
# 

library(MASS)
data(Boston)
names(Boston)
?Boston
set.seed(1)
train <- sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston <- tree(medv ~., Boston, subset = train)
summary(tree.boston)
# ploting the tree
plot(tree.boston)
text(tree.boston, pretty = 0)

# Cross Validation of this tree

cv.boston <- cv.tree(tree.boston)
plot(cv.boston$size, cv.boston$dev, type = "b")
prune.boston <-prune.tree(tree.boston, best=5)
plot(prune.boston)
text(prune.boston, pretty = 0)

# Here we use the unpurned tree to make predicions on the test set.

yhat <- predict(tree.boston, newdata = Boston[-train, ])
boston.test = Boston[-train, "medv"]
plot(yhat, boston.test)
abline(0,1)
mean((yhat-boston.test)^2)

# Exercises
#1 - Split the data set into a training set of size 200 and a test set (of the same
# size).
rm(list = ls())
library(tree)
library(ISLR)
data("Carseats")
names(Carseats)
attach(Carseats)
head(Carseats)
set.seed(2)
train <- sample(1:nrow(Carseats), 200)
test = -train
training_set = Carseats[train,]
testing_set = Carseats[test,]
testing_sales = Sales[test]

# 2. Fit a regression tree to the training set. Plot the tree, and interpret the
#    results. What test MSE do you obtain?
tree_model = tree(Sales~., training_set)
tree_model
plot(tree_model)
text(tree_model, pretty = 0)
# check the model using the testing data set.
tree_pred = predict(tree_model, testing_set)
mean((tree_pred - testing_sales)^2)
# the MSE is 4.84

# 3. Use cross-validation in order to determine the optimal level of tree com-
#    plexity. Does pruning the tree improve the test MSE?

# Lest do cross validation for prunning de tree
cv_tree <- cv.tree(tree_model)
names(cv_tree)
plot(cv_tree$size,
     cv_tree$dev,
     type = "b",
     xlab = "Tree Size",
     ylab = "MSE")
identify(cv_tree$size,
     cv_tree$dev)
which.min(cv_tree$dev)
cv_tree$size[2]

# prune the tree to the size 16 but is doesn't make sense
pruned_model = prune.tree(tree_model, 4)
plot(pruned_model)
text(pruned_model, pretty = 0)
# check the accuracy of the pruned model
# check the model using the testing data set.
tree_pred = predict(pruned_model, testing_set)
mean((tree_pred - testing_sales)^2)
# The MSE is 4.84
# We can not see any changes prunning the tree.