#Fitting Naive Bayes classifier Model
classifier <- naiveBayes(trainNB, df.train$class, laplace = 1)

#Predicting the sentiment for test data
pred <- predict(classifier, newdata=testNB)
t=table("Predictions"= pred, "Actual" = df.test$class )

#Accuracy of the model
acc<-sum(diag(t))/sum(t)
acc