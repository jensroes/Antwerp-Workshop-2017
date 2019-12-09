library(lme4)

data <- read.table("data/simDataSubjRE.txt", sep = "\t", head = T)
head(data)

# Sum contrast
contrasts(data$cond) <- c(-.5, .5)
colnames(contrasts(data$cond)) <- c("b-a")
contrasts(data$cond)

# Linear mixed effects model with random intercepts for each subject and slope adjustments
# Set REML = FALSE for comparing models with different fixed effects
# REML = residual maximum likelihood
mRE <- lmer(y ~ cond + (1+cond|subj), data, REML = FALSE)
summary(mRE)$coef

# Baseline model without parameter
mIcp <- lmer(y ~ 1 + (1+cond|subj), data, REML = FALSE)
summary(mIcp)$coef

# Model copmarison gives the p-value for improving the model fit when slope is added
anova(mIcp, mRE)

# Satterthwaite approximation
# Estimates the degrees of freedome
library(lmerTest)
mRE2 <- lmer(y ~ cond + (1+cond|subj), data, REML = FALSE)
summary(mRE2)$coef