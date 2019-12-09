library(ggplot2)
library(bayesplot)
library(rstanarm)
options(mc.cores = parallel::detectCores())

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# 2. Compare distribution of data to distribution of posterior predictive values
data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)

# Predict data
y_rep <- posterior_predict(m)
# Samples some data from posterior predicted data
y_samp = y_rep[sample(nrow(y_rep), 500, replace=TRUE),  ]

# Plot data and overlay data with posterior predictive distribution
pdf("slides/linearmodels/gfx/overlay.pdf", width = 5, height = 4, bg = "transparent", family = "Times")
color_scheme_set("red")
ppc_dens_overlay(y = data$y, 
                 yrep = y_samp)
dev.off()


# Plot the density distribution of the data and the posterior predictive values
pdf("slides/linearmodels/gfx/overlaycond.pdf", width =5, height = 4, bg = "transparent", family = "Times")
ppc_violin_grouped(y = data$y
                   , yrep = y_samp
                   ,  group = data$cond
                   , probs = c(0.1, 0.5, 0.9)
                   , y_draw = c("violin"))
dev.off()

