# Maximum A posteriori (MAP) estimate
# -----------------------------------
# Technically the MAP is simply the mode of the posterior distribution, i.e. the most frequent/likely
# estimate for the true parameter value (the effect).
# For effects that come from a simgle normal distribution, if shouldn't matter really
# whether we use the mean, median or mode to determine MAP.

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Extract posterior samples
samps <- as.data.frame(m) # It saves all the samples from the model.
(samps.names <- names(samps)) # Names of all parameters that had to be estimated

# Get posterior samples for the parameter of interest; i.e. the effect or the difference
samps.cond <- samps[,samps.names[2]]

# Estimates for the most probable value can be obtained by using R base functions for mean, median and mode
# In a perfect world with pefectly symmetric normal distributions the best estimate for the most probable 
# value should be the same for all three functions

# Mean of posterior samples
mean(samps.cond)

# Median of posterior samples
median(samps.cond)

# Model of posterior samples
mode(samps.cond)

# Ooops, what just happened? The mode() function in R does not give you the mode, annoyingly.
# If you want to figure out what it does, check ?mode


# Instead we can write a function that gives us the mode. 
mode.fct <- function(data) {
  unique.data <- unique(data)
  unique.data[which.max(tabulate(match(data, unique.data)))]
}

# NB, there are different ways this could be implemented for continous data, e.g.
#mode.dst <- function(x) {
#  d <- density(x)
#  d$x[which.max(d$y)]
#}

# Mode of posterior samples
mode.fct(samps.cond)

# Fair enough, mean, median and mode are all about the same really.

# Task 1: What's the MAP of the intercept value (remember, we are using sum coding which makes the intercept the grand mean)?

# Task 2: What's the MAP of the effect for subject 3?
# Hint: start by checking str(samps.cond)

# Task 3: One extremely convenient fact about Bayesian models is that they permit reparameterisation. That means from samples of the existing model
# we can calculate other probability distributions. For instance, use the posterior samples of the intercept and the slope to calculate the 
# MAP for each condition. Follow the instructions to get the posterior samples for each condition.

# Extract posterior samples for the intercept and the slope
intercept.posterior <- samps[,samps.names[1]]
slope.posterior <- samps[,samps.names[2]]

# Calculate the posterior sampes for cond a using the contrast coding used to extract the effect. For cond a
# we need to subtract the half of the slope from the intercept.
conda <- intercept.posterior + slope.posterior * -.5

# Remember the contrast (sum) coding the the slope parameter. Note cond a was coded -0.5. How would you calculate the posterior samples
# for cond b? How was cond b coded?

# Now, what's the MAP (using mean, median and mode) for each condition?

# Task 4: You can now also calculate the credible intervals for each condition. Try :)

# Task 5: ... and plot its distribution. 
hist(conda, 
     breaks = 50,
     xlab = expression(hat(y)),
     ylab = expression(paste("Probability of ", hat(beta))),
     col = "forestgreen",
     main = "Posterior probability distribution"
     ) 

# Plot the posterior probability distribution for cond b and the difference between cond a and b.

