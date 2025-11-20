library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

dnorm(0)
dnorm(1)
dnorm(-1)
vec <- seq(-5, 5, by = .1)
dnorm(vec)
plot(vec, dnorm(vec))

iq <- seq(50, 150, .1)
plot(iq, dnorm(iq, mean = 100, sd = 15))

pnorm(100, mean = 100, sd = 15)
pnorm(130, mean = 100, sd = 15)
pnorm(0, mean = 100, sd = 15)

set.seed(42)
samp <- rnorm(100, mean = 100, sd = 15)
hist(samp)
hist(rnorm(30))
mean(samp)

sqrt(sum((samp - mean(samp))^2)/(length(samp) - 1))
sd(samp)

#CI95%