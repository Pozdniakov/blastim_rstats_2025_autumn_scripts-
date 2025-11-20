set.seed(42)
samp <- rnorm(100, mean = 100, sd = 15)
samp
many_means <- replicate(1000000, mean(rnorm(100, mean = 100, sd = 15)))
mean(many_means)
sd(many_means)
se <- sd(samp)/sqrt(length(samp))

sem <- function(x) sd(x)/sqrt(length(x))

mean(samp) - se * qnorm(0.975)
mean(samp) + se * qnorm(0.975)

hist(many_means)

hist(rlnorm(100000),breaks = 1000)
many_means <- replicate(1000000, mean(rlnorm(100)))
hist(many_means)

mu <- 100
z_emp <- (mean(samp) - mu)/(15/sqrt(length(samp)))
z_emp
(1 - pnorm(z_emp)) * 2

t_emp <- (mean(samp) - mu)/(sd(samp)/sqrt(length(samp)))
t_emp
(1 - pt(t_emp, df = length(samp) - 1)) * 2
t.test(samp, mu = 105)

library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

t.test(heroes$Weight, mu = 100)

t.test(heroes$Height, mu = 185, alternative = "greater")

