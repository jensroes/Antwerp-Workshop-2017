library(SPIn) # For calculating the HPDI
library(rstanarm)

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Extract posterior samples
samps <- as.data.frame(m) # It saves all the samples from the model.
(samps.names <- names(samps)) # Names of all parameters that had to be estimated

# Get posterior samples for the parameter of interest; i.e. the effect or the difference
samps.cond <- samps[,samps.names[2]]

# Posterior credible interval
posterior_interval(m, par = "condb-a", prob = 0.95)

# 95% HDPI (highest posterior desnity interval)
bootSPIn(samps.cond)$spin

#-----------------------------------------------------------------------------
# Exercises: Bare in mind that using 95% as cut-off value for the probablity mass is entirely arbitrary
# and is only used to mirror frequentist confidence intervals.

# Task 1: Get the credible intervals and HPDI for 50% of the posterior probablility mass.

# Task 2: Get the credible intervals and HPDI for 89% of the posterior probablility mass.

# Task 3: Get the credible intervals and HPDI for 100% of the posterior probablility mass.

# Task 4: What's the 95% credible interval for the true parameter value of the intercept?
