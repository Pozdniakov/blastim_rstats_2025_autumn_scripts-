library(tidyverse)
diet <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/stcp-Rdataset-Diet.csv")
diet1 <- diet %>%
  filter(Diet == 1)

#t.test(diet1$pre.weight - diet1$weight6weeks, mu = 0)
t.test(diet1$pre.weight, diet1$weight6weeks, paired = TRUE)

diet2 <- diet %>%
  filter(Diet == 2)
t.test(diet2$pre.weight, diet2$weight6weeks, paired = TRUE)

diet3 <- diet %>%
  filter(Diet == 3)
t.test(diet3$pre.weight, diet3$weight6weeks, paired = TRUE)

diet12 <- diet %>%
  filter(Diet %in% 1:2)

#1
t.test(weight6weeks ~ Diet, data = diet12)
#2
t.test(diet12$weight6weeks ~ diet12$Diet)
#3
post_weight1 <- diet12 %>%
  filter(Diet == 1) %>%
  pull(weight6weeks)
post_weight2 <- diet12 %>%
  filter(Diet == 2) %>%
  pull(weight6weeks)
t.test(post_weight1, post_weight2, paired = FALSE)
sd(post_weight1)
sd(post_weight2)

t.test(weight6weeks ~ Diet, data = diet12, var.equal = TRUE)

diet23 <- diet %>%
  filter(Diet %in% 2:3)
t.test(weight6weeks ~ Diet, data = diet23)

diet13 <- diet %>%
  filter(Diet %in% c(1,3))
t.test(weight6weeks ~ Diet, data = diet13)

heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))
heroes_white_black <- heroes %>%
  filter(`Eye color` %in% c("white", "black"))

t.test(Weight ~ `Eye color`, data = heroes_white_black)

set.seed(42)
samp <- rnorm(100, mean = 100, sd = 15)
shapiro.test(samp)

shapiro.test(post_weight2)
hist(post_weight1, breaks = 10)
hist(rnorm(length(post_weight1)))
post_weight1 %>%
  length() %>%
  rnorm() %>%
  hist()

hist(post_weight2, breaks = 10)
qqnorm(post_weight1)
post_weight1 %>%
  length() %>%
  rnorm() %>%
  qqnorm()
qqnorm(post_weight2)
post_weight2 %>%
  length() %>%
  rnorm() %>%
  qqnorm()

t.test(diet1$pre.weight, diet1$weight6weeks, paired = TRUE)
wilcox.test(diet1$pre.weight, diet1$weight6weeks, paired = TRUE)

t.test(post_weight1, post_weight2, paired = FALSE)
wilcox.test(post_weight1, post_weight2, paired = FALSE)

diet13 <- diet %>%
  filter(Diet %in% c(1, 3))

wilcox.test(weight6weeks ~ Diet, diet13)

diet23 <- diet %>%
  filter(Diet %in% c(2, 3))
wilcox.test(weight6weeks ~ Diet, diet23)

diet2 <- diet %>%
  filter(Diet == 2)
wilcox.test(diet2$weight6weeks, diet2$pre.weight, paired = TRUE)
t.test(diet2$weight6weeks, diet2$pre.weight, paired = TRUE)

diet3 <- diet %>%
  filter(Diet == 3)
wilcox.test(diet3$weight6weeks, diet3$pre.weight, paired = TRUE)
t.test(diet3$weight6weeks, diet3$pre.weight, paired = TRUE)

a <- rnorm(5, mean = 0)
b <- rnorm(5, mean = 1000)
a
b

t.test(a, b, paired = TRUE)
wilcox.test(a, b, paired = TRUE)

tt <- t.test(a, b, paired = TRUE)
str(tt)
tt$p.value
tt$conf.int
tt$statistic

#install.packages("broom")
library(broom)
tidy(tt)

diet %>%
  group_by(Diet) %>%
  summarise(tidy(wilcox.test(weight6weeks, pre.weight, paired = TRUE)))
