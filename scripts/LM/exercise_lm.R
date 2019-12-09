# Exercise linear regression
library(ggplot2)

# Linear regression models can be used to infer the intercept and slope parameter from a data set.
# The following exericse intends to give you an understanding of the relationship of all model parameters, 
# the data (y) and the predictor (x).

#----
# Example 1
# Linear models allow us to predict potentially unobserved data points:
# Given ...
intercept = 10 # alpha
slope = 2 # beta; 2 units up on the y-axis
x = 1 # predictor; 1 unit to the right on the x-axis

# What's y (i.e. DV)?
(y = intercept + slope*1)

# Plot the regression line
p <- qplot(x = c(0,x), y = c(intercept, y), geom = "blank") +
  geom_line(aes(y = c(intercept, y)), col="red") +
  ylab("DV") +
  xlab("Predictor")
p <- p + theme_bw();p

#----
# Task 1
intercept = 13
slope = 4
x = 12

# What's y?


# Plot the regression line


#----
# Task 2
intercept = 13
slope = 4
x = 12

# What's y?


# Plot the regression line


#----
# Task 3
# Regression models allow us to infer the intercept.
# Given ...
slope = 3
x = 2
y = 12

# What's the intercept?


# Plot the regression line


#----
# Task 4
# You can also infer the linear change on the y-axis, if we move x units to the right on the x-axis.
# Given ...
intercept = 3
y = 10
x = 12

# What's slope?


# Plot the regression line


#----
# Task 5
# Having a data set with a predictor variable (your IV), you can infer both the intercept and the slope of a regression model.
# Simulate some data ...
set.seed(123)
N = 1000
mu = 150
sigma = 2.5
y <- rnorm(n = N, mean = mu, sd = sigma) # generate random data points (n = number of observations)
x <- sample(1:12, N, replace = TRUE) # random predictor variable
head(data <- data.frame(y, x)) # Create a data frame
nrow(data)

# Use the lm() function for linear regressions in R to infer the intercept and slope for this data set
# Run "?lm" to get help

# Plot the regression line

