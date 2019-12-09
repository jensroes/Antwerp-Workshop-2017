library(polspline) # For Bayes factors

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Extract posterior samples
samps <- as.data.frame(m) # It saves all the samples from the model.
(samps.names <- names(samps)) # Names of all parameters that had to be estimated

# Get posterior samples for the parameter of interest; i.e. the effect or the difference
samps.cond <- samps[,samps.names[2]]

# Bayes Factor using Savage-Dickey density ratio method (Dickey et al., 1970)
# Calculate Bayes Factor for effect condb-a
fit_posterior <- logspline(samps.cond) 
posterior <- dlogspline(0, fit_posterior) # Height of the posterior at 0 
prior <- dnorm(0, 0, 1) # Height of the prior at 0
(BF10 <- prior/posterior) # if > 10 support for H1

#-----------------------------------------------------------------------------
# Exercises: Bayes Factors determine the evidence for a particular model over another model.
# Above you have seen how to determine the evidence for the alternative hypothesis compared to
# the null hypothesis - i.e. how much more likely it is to see an difference between the conditions.

# Task 1: p-values indicate the probability of the data given that the null hypothesis is true. 
# Try to find the evidence (Bayes Factor) for the null hypothesis to be true compared to the alternative hypothesis.
# This Bayes Factor would be analogous to a frequentist p-value.

# Task 2: Find the evidence that the intercept parameter is different from null.  

