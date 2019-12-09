
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### FiRst steps ####

# position the cursor in the line below, press ctrl+ENTER
# see what appears in the console

'Hello World'

# now try the following

1

1 + 1

c(1,2,3) # a vector with three values. Vectors are just lists of values.

mean(c(1,2,3))

sum(c(1,2,3))

sd(c(1,2,3))

c(1,2,3) + c(3,2,1)

# and try this. See what appears in the Environment

a = 1 + 1

b = "Brexit"

c = a + 6

d = 0/0

e = c(1,2,3)

M = mean(e)

# ask R some "true or false" questions
# check that you agree with it

a > 1

a == 3

c != 8

c != .781

c == a

is.na(d)

!is.na(a)

b == 'an excellent idea'

# some more sums

x = c(1,1,1,2,3,3,3)

length(x)
sum(x)/length(x)
mean(x)
median(x)
sd(x)

# Use the broom to sweep the Environment clean.
# clear the console with CTRL+L (optional)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Get data ####

# get a very useful library (set of functions)
library(tidyverse)

# read data from a file into a dataframe called dat
dat <- read_delim("./data/bigr_data_anon_bysub.txt",
                  "\t", escape_double = FALSE, trim_ws = TRUE)

# find dat in your environment and click on it

# try the following
names(dat)
summary(dat)

dat$M_IKI
# you can read this as 
# "the variable (column) called M_IKI that belongs to the data frame called dat"

# what kind of a thing is M_IKI
str(dat$M_IKI)

# actually, before we go on, let's get rid of all those decimal places
dat$M_IKI <- round(dat$M_IKI,0)
dat$M_IKI

# explore M_IKI's distribution
summary(dat$M_IKI)
hist(dat$M_IKI)
hist(dat$M_IKI, breaks = 100)

# create a new variable
dat$log_MIKI <- log(dat$M_IKI)
# guess what this did (not difficult!) then check dat to see if you're right

# look at a grouping variable
str(dat$freq_grp)
dat$freq_grp

# convert to a factor (useful for analysis but can be confusing)
dat$freq_grp <- factor(dat$freq_grp)
str(dat$freq_grp)
summary(dat$freq_grp)
levels(dat$freq_grp)
contrasts(dat$freq_grp) #we'll return to this later

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# more sophisticated (but easy) data wrangling using tidyverse (dplyr) functions
#
# %>% means "pass what we've done so far on to the next function"
# the whole thing is called a pipe and runs as a unit
#
# 1. read through and work out what it does
# 2. run the whole thing and have a look at descs

descs <- dat %>% 
  filter(M_IKI < 300) %>% 
  group_by(freq_grp) %>% 
  summarise(M = mean(M_IKI), 
            SD = sd(M_IKI), 
            SE = SD/sqrt(length(M_IKI))) %>%
  mutate(CI = paste0(round(M-2*SE,0)," ,",round(M+2*SE,0)),
         M = round(M)) %>%
  select(freq_grp, M, CI)


# 3. run it in stages as follows, looking at the descs (descriptives) data frame
# each time to see what has changed.

# we are going to base this on dat
descs <- dat

# but we are going to remove outliers first
descs <- dat %>% 
  filter(M_IKI < 300)

# and then break it up into lo and hi frequency groups (no visible effect of this)
descs <- dat %>% 
  filter(M_IKI < 300) %>% 
  group_by(freq_grp)

# then we are going to find the mean, SD and standard error, 
# across subjects, within groups
descs <- dat %>% 
  filter(M_IKI < 300) %>% 
  group_by(freq_grp) %>% 
  summarise(M = mean(M_IKI), 
            SD = sd(M_IKI), 
            SE = SD/sqrt(length(M_IKI)))

# get a confidence interval, and tidy up M
descs <- dat %>% 
  filter(M_IKI < 300) %>% 
  group_by(freq_grp) %>% 
  summarise(M = mean(M_IKI), 
            SD = sd(M_IKI), 
            SE = SD/sqrt(length(M_IKI))) %>%
  mutate(CI = paste0(round(M-2*SE,0)," ,",round(M+2*SE,0)),
         M = round(M))

# and finally drop the variables we're not interested in any more
descs <- dat %>% 
  filter(M_IKI < 300) %>% 
  group_by(freq_grp) %>% 
  summarise(M = mean(M_IKI), 
            SD = sd(M_IKI), 
            SE = SD/sqrt(length(M_IKI))) %>%
  mutate(CI = paste0(round(M-2*SE,0)," ,",round(M+2*SE,0)),
         M = round(M)) %>%
  select(freq_grp, M, CI)


# Use the broom to sweep the Environment clean.
# clear the console with CTRL+L (optional)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


