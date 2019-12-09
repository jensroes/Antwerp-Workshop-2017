library(ggplot2)
library(bayesplot)
library(rstanarm)
library(SPIn) # For calculating the HPDI
library(polspline) # For Bayes factors
options(mc.cores = parallel::detectCores())

m <- readRDS(file="stanout/ModelSimData.rda")

summary(m, pars = "condb-a", probs = c(0.025, .975))


# Output summary
samps <- as.data.frame(m) # It saves all the samples from the model.
names(samps) # Names of all parameters that had to be estimated

# Or do
samples = ggmcmc::ggs(m
                      , family ="beta" #  slope
                      , inc_warmup = FALSE
                      , stan_include_auxiliar = FALSE
)

# histogram of effect beta
pdf("slides/linearmodels/gfx/effectdist.pdf", width =5, height = 4, bg = "transparent", family = "Times")
ggmcmc::ggmcmc(
  D = samples
  ,file = NULL
  ,plot = 'ggs_histogram'
  ,param_page = 1
)
dev.off()

# Extract posterior samples for the parameter of interest; i.e. the effect
post <- samps[,"condb-a"]

# Summarise effect statistics
cbind(Median = median(post), # maximum a posteriori estimate
               posterior_interval(m, par = "condb-a", prob = 0.95),
               "P<0" = mean(post < 0)) # Probability that the effect is smaller than 0

# 95% HDPI (highest posterior desnity interval)
bootSPIn(post)$spin


# Bayes Factor using Savage-Dickey density ratio method (Dickey et al., 1970)
# Calculate Bayes Factor for effect condb-a
fit_posterior <- logspline(post) 
posterior <- dlogspline(0, fit_posterior) # Height of the posterior at 0 
prior <- dnorm(0, 0, 1) # Height of the prior at 0
(BF10 <- prior/posterior) # if > 10 support for H1


