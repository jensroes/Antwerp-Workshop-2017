# Simulate data
set.seed(123)
N = 30 # number of subjects
K = 10 # number of observations per subject per condition

# Population parameters
intercept_mean <- 100
intercept_sd <- 10
slope_mean <- 50 # we know the underlying effect !!!!!!!!
slope_sd <- 10
error <- 10 # trial-by-trial error

intercept <- rnorm(N, intercept_mean, intercept_sd)
slope <- rnorm(N, slope_mean, slope_sd)

# iterate over subject to generate data for each one
data <- NULL

for(s in 1:N){
  data = rbind(
    data
    , data.frame(
      subj = s
      , cond = 'a'
      , y = rnorm(K, intercept[s] - .5*slope[s], error)
    )
    , data.frame(
      subj = s
      , cond = 'b'
      , y = rnorm(K, intercept[s] + .5*slope[s], error)
    )
  )
}

# factorize id and condition
data$subj = as.factor(data$subj)
data$cond = as.factor(data$cond)

write.table(data, "data/simDataSubjRE.txt", row.names = FALSE, quote = FALSE, sep = "\t")
