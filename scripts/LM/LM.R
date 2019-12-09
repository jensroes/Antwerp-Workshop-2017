# Simple linear regression model

# Number of data
N <- 1000

# Population parameters
intercept_mean <- 100
intercept_sd <- 15
slope_mean <- 20
slope_sd <- 3
error <- 10 # trial-by-trial error

intercept <- rnorm(N, intercept_mean, intercept_sd)
slope <- rnorm(N, slope_mean, slope_sd)

data <- data.frame(cond = sort(rep(c("a", "b"), N/2)))
data$y <- NA
data[data$cond == "a",]$y <- rnorm(N/2, intercept, error)
data[data$cond == "b",]$y <- rnorm(N/2, intercept + slope, error)


#contrasts(data$cond)  <- c(-.5, .5)

hist(data$y)

m <- lm(y ~ cond, data)
summary(m)$coef
