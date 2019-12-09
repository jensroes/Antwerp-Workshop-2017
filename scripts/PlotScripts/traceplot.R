library(ggplot2)
library(bayesplot)

# Load model
m <- readRDS(file="stanout/ModelSimData.rda")

# Extract posterior samples
samples = ggmcmc::ggs(m
                      , family = "beta" #  slope
                      , inc_warmup = FALSE
                      , stan_include_auxiliar = FALSE
)
samples

# traceplot
pdf("slides/linearmodels/gfx/traceplot.pdf", width = 6, height = 4, bg = "transparent", family = "Times")
ggmcmc::ggmcmc(
  D = samples
  ,file = NULL
  ,plot = 'ggs_traceplot'
  ,param_page = 1
)
dev.off()


