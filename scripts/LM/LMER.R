library(lme4)
library(ggplot2)

N = 30 # number of subjects
K = 24 # number of observations per subject per condition

# Population parameters
intercept_mean <- 100
intercept_sd <- 15
slope_mean <- 50 # we know the underlying effect
slope_sd <- 3
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
      , y = rnorm(K, intercept[s], error)
    )
    , data.frame(
      subj = s
      , cond = 'b'
      , y = rnorm(K, intercept[s] + slope[s], error)
    )
  )
}

# factorize id and condition
data$subj = factor(data$subj)
data$cond = factor(data$cond)
p <- ggplot(data, aes(x=cond, y=y, colour=subj, group=subj)) + 
  geom_line() 
 