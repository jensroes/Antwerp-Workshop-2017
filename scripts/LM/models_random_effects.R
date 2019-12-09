library(lme4)
library(dplyr)
#library(stargazer)

data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)
head(data)

# Sum contrast
contrasts(data$cond) <- c(-.5, .5)
colnames(contrasts(data$cond)) <- c("b-a")
contrasts(data$cond)

# Linear regression on unaggregated data
m1 <- lm(y ~ cond , data)
summary(m1)$coef
#stargazer(summary(m1)$coef)

# Aggregate data
data.subj <- data %>% 
  group_by(subj,cond) %>%
  summarise(ysubjmeans = mean(y))

# Linear regression model on aggregated data
m2 <- lm(ysubjmeans ~ cond, data.subj)
summary(m2)$coef
#stargazer(summary(m2)$coef)

# Linear mixed effects model with random intercepts for each subject
m3a <- lmer(y ~ cond + (1|subj), data)
summary(m3a)$coef
#stargazer(summary(m3a)$coef)

# Linear mixed effects model with random intercepts for each subject and slope adjustments
m3b <- lmer(y ~ cond + (1+cond|subj), data)
summary(m3b)$coef
#stargazer(summary(m3b)$coef)
