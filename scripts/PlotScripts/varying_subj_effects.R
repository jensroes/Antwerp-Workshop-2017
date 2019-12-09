library(ggplot2)

data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)
head(data)

p <- ggplot(data) + 
  aes(x = cond, y = y) + 
  theme_bw(base_size = 12) +
  stat_smooth(method = "lm", se = FALSE, aes(group = 1), col = "red") +
  # Put the points on top of lines
  facet_wrap("subj") +
  labs(x = "cond", y = "y")  
pdf("slides/linearmodels/gfx/varyingeffects.pdf", width = 7, height = 5, bg = "transparent", family = "Times")
p
dev.off()
