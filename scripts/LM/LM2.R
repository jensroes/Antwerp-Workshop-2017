# Simple linear regression model
library(ggplot2) # for graphs
set.seed(12)

# Simulate data
# Number of data
N <- 1000

# Population parameters
intercept_mean <- 100
intercept_sd <- 15
slope_mean <- 20 # we know the underlying effect
slope_sd <- 3
error <- 100 # trial-by-trial error

intercept <- rnorm(N, intercept_mean, intercept_sd)
slope <- rnorm(N, slope_mean, slope_sd)

data <- data.frame(cond = sample(0:10, N, replace = TRUE))
data$y <- rnorm(N, intercept + slope*data$cond, error)

#contrasts(data$cond)  <- c(-.5, .5)
# Distribution of data
hist(data$y)

# Linear regression model
m <- lm(y ~ cond, data)
summary(m)$coef

# Predict new data
data$ypred <- fitted(m)

# Plot regression model
p <- ggplot(data, aes(x=cond, y=y)) +
  geom_point(shape=1) +    # Use hollow circles
  geom_line(aes(y=ypred), col="red")
  #geom_smooth(method=lm)    # Add linear regression line 
                            #  (by default includes 95% confidence region)
p <- p + theme_bw()
p

