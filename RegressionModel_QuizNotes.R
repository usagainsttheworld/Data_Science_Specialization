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

#Quiz2
#Q1 Give a P-value for the two sided hypothesis test of whether β1 from a linear regression model is 0 or not.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit <- lm(y ~ x)
summary(fit)

#Q2 Consider the previous problem, give the estimate of the residual standard deviation.
summary(fit)$sigma

#Q3 In the mtcars data set, fit a linear regression model of weight (predictor) on mpg (outcome). Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?
attach(mtcars)
fit<- lm(mpg ~ wt)
newdata <- data.frame(wt=mean(wt))
predict(fit, newdata, interval="confidence")
detach(mtcars)

#Q4 Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?
?mtcars

#5 Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds. Construct a 95% prediction interval for its mpg. What is the upper endpoint?
attach(mtcars)
fit<- lm(mpg ~ wt)
newdata <- data.frame(wt = 3)
predict(fit, newdata, interval="prediction")
detach(mtcars)

#Q6 Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs). A “short” ton is defined as 2,000 lbs. Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight. Give the lower endpoint.?????
data(mtcars)
fit<- lm(mpg ~ I(wt*0.5), data = mtcars)
confint(fit)

#Q7 If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?
data(mtcars)
fit<- lm(mpg ~ I(wt))
summary(fit)$coefficients
fit2<- lm(mpg ~ I(wt/100))
summary(fit2)$coefficients

#Q8 I have an outcome, Y, and a predictor, X and fit a linear regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1. What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, X+c for some constant, c?
data(mtcars)
fit<- lm(mpg ~ I(wt))
summary(fit)$coefficients
fit3<- lm(mpg ~ I(wt+2))
summary(fit3)$coefficients

#Q9 Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. About what is the ratio of the the sum of the squared errors, ∑ni=1(Yi−Y^i)2 when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?
data(mtcars)
fit4 <- lm(mpg ~ 1)
fit <- lm(mpg ~ wt)
anova(fit)
anova(fit4)






