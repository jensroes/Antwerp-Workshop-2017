# Simple linear regression model
library(ggplot2) # for graphs

data <- read.table("data/simData.txt", head = T, sep = "\t")

# Plot regression model
p <- ggplot(data, aes(x=cond, y=y)) +
  geom_boxplot() +
  geom_smooth(method=lm, col = "red", aes(group = 1), se = FALSE)    # Add linear regression line 
p <- p + scale_y_continuous(name = "y", breaks = seq(0, 200, 50))
p <- p + theme_bw(base_size = 14)
p <- p + annotate("text", y = 150, x = 1, label = "y = 75 + 50 * x\n x in {0,1}")
p

pdf("slides/linearmodels/gfx/lmdiscrete.pdf", width = 5, height = 4, bg = "transparent", family = "Times")
p
dev.off()
