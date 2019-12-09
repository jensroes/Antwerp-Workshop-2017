# Simple linear regression model
library(ggplot2) # for graphs

data <- read.table("data/simDataCont.txt", head = T, sep = "\t")


# Plot regression model
p <- ggplot(data, aes(x=cond, y=y)) +
  geom_smooth(method=lm, col = "red")    # Add linear regression line 
p <- p + scale_x_discrete(name = "cond", limits = seq(0,max(data$cond),1))
p <- p + scale_y_continuous(name = "y", breaks = seq(100, 600, 50))
p <- p + theme_bw(base_size = 14)
p <- p + annotate("text", y = 350, x = 2, label = "y = 100 + 50 * x\n x in {0 ... 10}")
p

pdf("slides/linearmodels/gfx/lm.pdf", width = 5, height = 4, bg = "transparent", family = "Times")
p
dev.off()
