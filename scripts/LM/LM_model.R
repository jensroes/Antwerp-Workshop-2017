# Simple linear regression model
library(dplyr) # Data processing

# Load data
data <- read.table("data/simDataCont.txt", head = T, sep = "\t")

# Distribution of data
hist(data$y,
     main = "Histogram of y",
     breaks = 50)

# Linear regression model
m <- lm(y ~ cond, data)
summary(m)$coef
