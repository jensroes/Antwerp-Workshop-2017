library(lme4)
library(ggplot2)

data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)
head(data)

# Sum contrast
contrasts(data$cond) <- c(-.5, .5)
colnames(contrasts(data$cond)) <- c("b-a")
contrasts(data$cond)

# Linear mixed effects model with random intercepts for each subject and slope adjustments
# Set REML = FALSE for comparing models with different fixed effects
# REML = residual maximum likelihood
mRE <- lmer(y ~ cond + (1+cond|subj), data, REML = FALSE)
summary(mRE)$coef

# Get 95% confidence interval
confint(mRE, parm = "condb-a", level = 0.95)

# For an alpha level of .05 the CI is set to .95.

# Task 1: Generate a CI for an alpha level of .01.

# Task 2: Generate a CI for an alpha level of .001.

# Task 3: The simulated data have a true parameter value of 50 (i.e. slope; difference between cond a and b).
# Is the true parameter value contained in the interval? 
# At what confidence level is the true parameter value outside of the CI.