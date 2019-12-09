library(lme4)
library(ggplot2)
library(dplyr)
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
      , y = rnorm(K, intercept[s] - .5*slope, error)
    )
    , data.frame(
      subj = s
      , cond = 'b'
      , y = rnorm(K, intercept[s] + .5*slope, error)
    )
  )
}

p <- ggplot(data) + 
  aes(x = cond, y = y) + theme_bw(base_size = 12) +
  stat_smooth(method = "lm", se = FALSE, aes(group = 1), col = "red") +
  facet_wrap("subj") +
  labs(x = "cond", y = "y")  
pdf("slides/linearmodels/gfx/varyingintercepts.pdf", width = 7, height = 5, bg = "transparent", family = "Times")
p
dev.off()

