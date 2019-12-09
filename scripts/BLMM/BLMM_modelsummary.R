# Summary of the posterior effect
library(ggplot2)
library(bayesplot)
library(rstanarm)
library(SPIn) # For calculating the HPDI
library(polspline) # For Bayes factors

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Output summary
summary(m, pars = "condb-a", probs = c(0.025, .975))

# Extract posterior samples
samps <- as.data.frame(m) # It saves all the samples from the model.
(samps.names <- names(samps)) # Names of all parameters that had to be estimated


plot_title <- ggtitle("Posterior distribution",
                      "with median and 95% credible interval")
mcmc_areas(samps, 
           pars = "condb-a", 
           prob = 0.95) + plot_title

# Or do
samples = ggmcmc::ggs(m
                      , family ="beta" #  slope
                      , inc_warmup = FALSE
                      , stan_include_auxiliar = FALSE
)

# Plots help communicating findings. 
# Histogram of effect beta
ggmcmc::ggmcmc(
  D = samples
  ,file = NULL
  ,plot = 'ggs_histogram'
  ,param_page = 1
)


# Get posterior samples for the parameter of interest; i.e. the effect or the difference
samps.cond <- samps[,samps.names[2]]

# Summarise effect statistics
cbind(Median = median(samps.cond), 
               posterior_interval(m, par = "condb-a", prob = 0.95),
               "P<0" = mean(samps.cond < 0)) # Probability that the effect is smaller than 0

# or 95% HDPI (highest posterior desnity interval)
bootSPIn(samps.cond)$spin

# Bayes Factor using Savage-Dickey density ratio method (Dickey et al., 1970)
# Calculate Bayes Factor for effect condb-a
fit_posterior <- logspline(samps.cond) 
posterior <- dlogspline(0, fit_posterior) # Height of the posterior at 0 
prior <- dnorm(0, 0, 1) # Height of the prior at 0
(BF10 <- prior/posterior) # if > 10 support for H1
