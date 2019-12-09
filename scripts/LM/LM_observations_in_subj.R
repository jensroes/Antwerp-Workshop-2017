library(lme4)
library(dplyr)

data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)

# Preview of data
head(data)

# Sum contrast
contrasts(data$cond) <- c(-.5, .5)
colnames(contrasts(data$cond)) <- c("b-a")
contrasts(data$cond)

#------------------------------------------------------------------------------------
# Task 1: Fit linear regression model lm() on the data and assign the output to m1; e.g.
# m1 <- lm(y ~ cond, data)
# Apply the summary() function to the variable you saved the model to and inspeact the output.


#------------------------------------------------------------------------------------
# Task 2: Given the aggregated data for of the data set above.

# Aggregate subj data across trial; renders one observation per subject, per condition
data.subj <- data %>% 
  group_by(subj,cond) %>%
  summarise(ysubjmeans = mean(y))

# Preview of aggregated data frame
head(data.subj)

# Fit linear regression model lm() on the aggregated data "data.subj" and save the output into a new variable

# Inspect the outpu using the summary function; try and add $coef as in summary()$coef to see the model coefficients.


#------------------------------------------------------------------------------------
# Task 3: Fit two linear mixed effects model using the lmer() function on the data "data"
# The syntax is similar to lm() but you need to add an statement about the random effects structure.
# First model: Each subject has a different average speed - some are slower, some are faster. Varying intercepts models account for this.
# Add vayrinng intercepts for subjects; syntax: "fixed effect + (1|subj)"

# Second model: in addition to the random intercepts, allow the slope of each subject to vary by cond: "+ (1+cond|subj)". 
# This accounts for the fact that the effect (speed up across condition) might be larger for some subjects compared to others.


# Aside: the model syntax states as well that random slopes and intercepts are correlated. This means the effect might be
# smaller or larger for subjects with a high or low average speed. To uncorrelate slopes and intercepts you can either replace the 1 by 0,
# or use || instead of | in (cond|subj). However, its unlikely that you really want to do that unless you want to compare non-converging models
# and remove slopes that to not contribute to the model fit - a better solution is Bayesian models (Bates et al., 2016). 


# What differences do you observe? Which parts of the analysis changed? Compare both models to the lm() analysis using aggregated data.
# Save each model to new variable and inspect the output using summary()$coef.
