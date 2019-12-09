# Simulate data
set.seed(12)

# Simulate data
# Number of data
N <- 1000

# Population parameters
intercept_mean <- 100
intercept_sd <- 15
slope_mean <- 50 # we know the underlying effect
slope_sd <- 3
error <- 10 # trial-by-trial error

intercept <- rnorm(N, intercept_mean, intercept_sd)
slope <- rnorm(N, slope_mean, slope_sd)

data <- data.frame(cond = sample(c("a", "b"), N, replace = TRUE))
data$cond <- as.factor(data$cond)
x <- as.integer(data$cond)-1.5
data$y <- rnorm(N, intercept + slope*x, error)

write.table(data, "data/simData.txt", row.names = FALSE, quote = FALSE, sep = "\t")
