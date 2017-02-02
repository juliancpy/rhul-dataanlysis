library(MASS)
library(ISLR)
data(Boston)
attach(Boston)
names(Boston)
?Boston
lm.fit <- lm(medv~lstat)
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
predict(lm.fit, data.frame(lstat=c(5,10,15)))
plot(lstat, medv)
abline(lm.fit)
abline(lm.fit, lwd=3)
abline(lm.fit, lwd=3, col="red")
plot(lstat, medv, col="red")
plot(lstat, medv, pch=20)
plot(lstat, medv, pch="+")
plot(1:20, 1:20, pch=1:20)
# In order to t a multiple linear regression model using Least Squares, we
# again use the lm() function. The syntax lm(y~x1+x2+x3) is used to t a model
# with three attributes, x1, x2, and x3.
lm.fit <- lm(medv~lstat+age, data=Boston)
lm.fit
lm.fit <- lm(medv~., data = Boston)
lm.fit
fix(Carseats)
names(Carseats)
lm.fit <- lm(Sales~., data=Carseats)
lm.fit
attach(Carseats)
contrasts(ShelveLoc)
names(Smarket)
summary(Smarket)
attach(Smarket)
#The syntax of the
#glm() function is similar to that of lm(), except that we must pass in the
#argument family=binomial in order to tell R to run a logistic
glm.fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Smarket, family=binomial)
glm.fit 

coef(glm.fit)

glm.probs <- predict(glm.fit, type = "response")
glm.probs[1:6]

contrasts(Direction)
glm.pred <- rep("Down", 1250)
glm.pred[glm.probs>.5]<- "Up"

table(glm.pred, Direction)
mean(glm.pred==Direction)


#In order to better assess the accuracy of the logistic regression model in this setting, we will
#now train the algorithm using part of the data, and then examine how well it
#predicts the held out data.
#To implement this strategy, we will rst create a vector corresponding to
#the observations from 2001 through 2004, and then use this vector to create the
#held out data set of observations from 2005.

train <- (Year<2005)
Smarket.2005<-Smarket[!train,]
dim(Smarket.2005)

Direction.2005 <- Direction[!train]

glm.fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Smarket,
               family=binomial, subset = train)
glm.probs <- predict(glm.fit, Smarket.2005, type="response")
glm.pred <- rep("Down", 252)
glm.pred[glm.probs>.5] <- "Up"
table(glm.pred, Direction.2005)
mean(glm.pred== Direction.2005)
mean(glm.pred!=Direction.2005)
# Let us now ret logistic regression using just Lag1 and Lag2, which appear
# to be the most relevant (being most recent of the lags) attributes.
glm.fit <- glm(Direction~Lag1+Lag2,data = Smarket,
               family=binomial, subset = train)
glm.probs <- predict(glm.fit, Smarket.2005, type="response")
glm.pred <- rep("Down", 252)
glm.pred[glm.probs>.5] <- "Up"
table(glm.pred, Direction.2005)
mean(glm.pred== Direction.2005)
mean(glm.pred!=Direction.2005)

# Suppose that we want to predict the returns associated with particular values
# of Lag1 and Lag2. In particular, we want to predict Direction on a day when
# Lag1 and Lag2 equal 1:2 and 1:1, respectively, and on a day when they equal
# 1:5 and 􀀀0:8. We do this using the predict() function.
predict(glm.fit, newdata = data.frame(Lag1=c(1.2,1.5), Lag2=c(1.1,-0.8)), type = "response") 


# KNN

