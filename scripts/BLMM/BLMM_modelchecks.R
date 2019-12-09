library(ggplot2)
library(bayesplot)
library(rstanarm)
options(mc.cores = parallel::detectCores())

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Output
samps <- as.data.frame(m) # It saves all the samples from the model.
names(samps) # All parameters that had to be estimated

# 1. Test for convergence using Rubin-Gelman statistic
rhat <- summary(m)[, "Rhat"]
round(rhat, 2)

# Check if any is not 1
rhat[round(rhat, 1) != 1]


# 2. Compare distribution of data to distribution of posterior predictive values
data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)

# Predict data
y_rep <- posterior_predict(m)
# Samples some data from posterior predicted data
y_samp = y_rep[sample(nrow(y_rep), 500, replace=TRUE),  ]

# Plot data and overlay data with posterior predictive distribution
color_scheme_set("red")
ppc_dens_overlay(y = data$y, 
                 yrep = y_samp)


# Task: Increase and descrese the number of samples from the posterior predictive distirbution
# and compare these values to the data (plot).



# Plot the density distribution of the data and the posterior predictive values
ppc_violin_grouped(y = data$y
                   , yrep = y_samp
                   ,  group = data$cond
                   , probs = c(0.1, 0.5, 0.9)
                   , y_draw = c("violin"))


# Task: The probs argument defines the quanties represented in the violin plots. Change the probs argument
# (i) to display the 95% credible interval (range between 0.025 and 0.975)

# (ii) and the 89% credible interval


# 3. Check posterior
# Extract posterior samples
samples = ggmcmc::ggs(m
                      , family = "beta" #  slope
                      , inc_warmup = FALSE
                      , stan_include_auxiliar = FALSE
)
samples

# traceplot
ggmcmc::ggmcmc(
  D = samples
  ,file = NULL
  ,plot = 'ggs_traceplot'
  ,param_page = 1
)

# full vs partial density histogramm of mu values
ggmcmc::ggmcmc(
  D = samples,
  file = NULL,
  plot = 'ggs_compare_partial'
)

# auto-correlation
ggmcmc::ggmcmc(
  D = samples,
  file = NULL,
  plot = 'ggs_autocorrelation'
)

# Task: redo "3. Check posterior" for the intercept. 
# Hint, the slopes are often referred to as betas and intercept as "alpha".
# Does it look like the model converged properly for the intercept?

