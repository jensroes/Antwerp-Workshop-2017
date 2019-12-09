# Simple linear regression model
library(ggplot2) # for graphs
library(dplyr)
#library(stargazer)

data <- read.table("data/simData.txt", head = T, sep = "\t")

# Distribution of data
hist(data$y, 
     main = "Histogram of y",
     breaks = 50)

data %>% 
  group_by(cond) %>%
  summarise (mean = mean(y),
             sd = sd(y))

# Linear regression model
m <- lm(y ~ cond, data)
summary(m)$coef
#stargazer(summary(m)$coef)

# Define sum contrast to isolate the effect magnitude
contrasts(data$cond)
contrasts(data$cond) <- c(-.5, .5)
colnames(contrasts(data$cond)) <- c("b-a")
contrasts(data$cond)

# Linear regression model
m2 <- lm(y ~ cond, data)
summary(m2)$coef
#stargazer(summary(m2)$coef)

# Predict new data
#data$ypred <- fitted(m)

