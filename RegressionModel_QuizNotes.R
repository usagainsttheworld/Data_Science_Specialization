#Quiz 1
#Q1 Give the value of μ that minimizes the least squares equation ∑ni=1wi(xi−μ)2
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
print (sum(x*w)/sum(w))

#Q2 Fit the regression through the origin and get the slope treating y as the outcome and x as the regressor. (Hint, do not center the data since we want regression through the origin, not through the means of the data.)
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm (y ~ 0 + x)

#Q3 Do data(mtcars) from the datasets package and fit the regression model with mpg as the outcome and weight as the predictor. Give the slope coefficient.
library (datasets)
data(mtcars)
head(mtcars)
lm (mpg ~ wt, data = mtcars)

#Q4 Consider data with an outcome (Y) and a predictor (X). The standard deviation of the predictor is one half that of the outcome. The correlation between the two variables is .5. What value would the slope coefficient for the regression model with Y as the outcome and X as the predictor?
slope=cor(Y,X)*(sd(Y)/sd(X))=0.5*(1/0.5)

#Q5 Students were given two hard tests and scores were normalized to have empirical mean 0 and variance 1. The correlation between the scores on the two tests was 0.4. What would be the expected score on Quiz 2 for a student who had a normalized score of 1.5 on Quiz 1?
slope=cor(Y,X)*(sd(Y)/sd(X))=cor(Y,X)*(sqrt(var(Y)/var(X))=0.4
y=slope*x=0.4*1.5

#Q6 What is the value of the first measurement if x were normalized (to have mean 0 and variance 1)?
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
x0 <- x-mean(x) #make zero-mean by removing the average
x0/sd(x0) #unit variance (var 1) by dividing by the sd

#7 Consider the following data set (used above as well). What is the intercept for fitting the model with x as the predictor and y as the outcome?
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm (y ~ x)

#Q9 What value minimizes the sum of the squared distances between these points and itself?
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)

#Q10 Let the slope having fit Y as the outcome and X as the predictor be denoted as β1. Let the slope from fitting X as the outcome and Y as the predictor be denoted as γ1. Suppose that you divide β1 by γ1; in other words consider β1/γ1. What is this ratio always equal to?
β1=Cor(Y,X)SD(Y)/SD(X) 
γ1=Cor(Y,X)SD(X)/SD(Y)


