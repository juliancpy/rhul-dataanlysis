library(randomForest)
library(MASS)
set.seed(1)
train <- sample(1:nrow(Boston), nrow(Boston)/2)
bag.boston <- randomForest(medv~.,data=Boston, subset=train, mtry=13)
bag.boston
yhat.bag <- predict(bag.boston, newdata = Boston[-train,])
boston.test<-Boston[-train,"medv"]
plot(yhat.bag, boston.test)
abline(0,1,col="red")
mean((yhat.bag-boston.test)^2)

bag.boston<-randomForest(medv~.,data=Boston,subset=train, mtry=13,ntree=25)
yhat.bag<-predict(bag.boston, newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)
set.seed(1)
rf.boston<-randomForest(medv~.,data=Boston,subset=train, mtry=6)
yhat.rf<-predict(rf.boston, newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)