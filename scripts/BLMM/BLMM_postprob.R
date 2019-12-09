# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Extract posterior samples
samps <- as.data.frame(m) # It saves all the samples from the model.
(samps.names <- names(samps)) # Names of all parameters that had to be estimated

# Get posterior samples for the parameter of interest; i.e. the effect or the difference
samps.cond <- samps[,samps.names[2]]

# Summarise effect statistics
mean(samps.cond < 0) # Probability that the effect is smaller than 0

#-----------------------------------------------------------------------------
# Exercises

# Task 1: Depending on our hypothesis we might be more interested in the probability of seeing a slow-down rather than
# a speed-up in the tested effect. Find the posterior probability that the true parameter value is larger than 0, hence that there was a slow-down.

# Task 2: There is nothing special about 0 really. The probability of th effect being exaclty 0 is very low anyway. Also, very small effect
# such as 5ms or 10ms are not very informative either. Find the posterior probability of the true parameter value of the effect is smaller than
# a. 30
# b. 50
# c. 80
# d. 100


# Task 3: What's the posterior probability that subject 29 has a speed-up effect (negative slope/difference)?
# Hint: check str(samps.cond)

