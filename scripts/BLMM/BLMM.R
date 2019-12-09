library(rstanarm)
options(mc.cores = parallel::detectCores()) # for running chains in parallel

# Load data
data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)

# Check data
head(data)

# Sum contrast
contrasts(data$cond) <- c(-.5, .5)
colnames(contrasts(data$cond)) <- c("b-a")
contrasts(data$cond)

# Fit BLMM
m <- stan_lmer(y ~ cond # Fixed effects
               + (1 + cond | subj) # Random effects
                , prior_intercept = student_t(df = 1, location = 0) # Prior on intercept
                , prior = student_t(df = 1, location = 0) # Priors on slopes
                , data = data,
               chains = 3, # number of chains (use at least 3)
               iter = 1000, # number of iterations per chain
               cores = 4, # number of cores of your computer for parallel chains
               seed = 17) # use some number for replicatability

# Save model output
saveRDS(m,
     file="stanout/ModelSimData.rda",
     compress="xz")
