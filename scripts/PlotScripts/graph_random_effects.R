library(ggplot2)
library(dplyr)

data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)
head(data)

# Plot raw data
p1 <- ggplot(data, aes(x=cond, y=y))
p1 <- p1 + geom_jitter() + geom_boxplot() + theme_bw(base_size = 14)
p1 <- p1 + scale_x_discrete(name = "x")
p1 <- p1 + scale_y_continuous(breaks = seq(0,300,50))
pdf("slides/linearmodels/gfx/rawdata.pdf", width = 5, height = 4, bg = "transparent", family = "Times")
p1
dev.off()

# Plot aggregated data
data.subj <- data %>% 
  group_by(subj,cond) %>%
  summarise(ysubjmeans = mean(y))

p2 <- ggplot(data.subj, aes(x=cond, y=ysubjmeans))
p2 <- p2 + geom_jitter() + geom_boxplot() + theme_bw(base_size = 14)
p2 <- p2 + scale_x_discrete(name = "x")
p2 <- p2 + scale_y_continuous(breaks = seq(0,300,50))
p2 <- p2 + ylab("y (aggregated)")
pdf("slides/linearmodels/gfx/aggregateddata.pdf", width = 5, height = 4, bg = "transparent", family = "Times")
p2
dev.off()

# Add regression line
p2 <- p2 + geom_smooth(method=lm, col = "red", aes(group = 1), se = FALSE)    # Add linear regression line 
pdf("slides/linearmodels/gfx/aggregateddatareg.pdf", width = 5, height = 4, bg = "transparent", family = "Times")
p2
dev.off()


