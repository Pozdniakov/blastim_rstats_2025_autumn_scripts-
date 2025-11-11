library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))
weight <- heroes %>%
  drop_na(Weight) %>%
  pull(Weight)

options(scipen = 999)

# Меры рассеяния ----------------------------------------------------------

diff(range(weight))

sum((weight - mean(weight)) ^ 2)/(length(weight) - 1)

var(weight)

sqrt(sum((weight - mean(weight)) ^ 2)/(length(weight) - 1))
sd(weight)

sd(c(weight, 100500))
var(c(weight, 100500))

median(abs(weight - median(weight))) * 1.4826
mad(weight)
mad(c(weight, 100500))

IQR(weight)
IQR(c(weight, 100500))


# Ассиметрия и эксцесс ----------------------------------------------------

#install.packages("psych")
psych::skew(weight)
psych::kurtosi(weight)

# А теперь все вместе -----------------------------------------------------

summary(weight)
summary(heroes)

psych::describe(weight)
heroes %>%
  group_by(Gender) %>%
  summarise(psych::describe(Weight))

install.packages("skimr")
skimr::skim(weight)
heroes %>%
  #group_by(Gender) %>%
  skimr::skim()

heroes %>%
  filter(nchar(name) == 1)

heroes %>%
  group_by(Gender) %>%
  skimr::skim(ends_with("color"))

xxx
median(xxx$x)
median(xxx$y)
cor(xxx$x, xxx$y)

skimr::skim(xxx)
psych::describe(xxx)
var(xxx$x)
var(xxx$y)
plot(xxx)

# Визуализация данных в base R --------------------------------------------

plot(heroes$Height, heroes$Weight)
iris %>%
  select(!Species) %>%
  plot()
plot(weight)

hist(weight)
length(weight)

hist(weight, breaks = 100)

boxplot(Weight ~ Alignment, heroes)

c(1, 2, 4, 5, 8, 12, 14, 30)

ggplot() +
  geom_point(data = heroes, aes(x = Height, y = Weight, size = Weight), shape = "🍩")

ggplot() +
  geom_point(data = heroes, aes(x = Height,
                                y = Weight,
                                size = Weight,
                                colour = Gender))

ggplot() +
  geom_point(data = heroes, aes(x = Height,
                                y = Weight,
                                size = Weight), colour = "#24AA80")

ggplot() +
  geom_point(data = heroes, aes(x = Height,
                                y = Weight,
                                size = Weight), colour = "#00FF00")

ggplot() +
  geom_histogram(data = heroes, aes(x = Weight),
                 bins = 40, 
                 fill = "#AA3080")

ggplot() +
  geom_histogram(data = heroes, aes(x = Weight, fill = Gender),
                 bins = 40)

ggplot() +
  geom_density(data = heroes, aes(x = Weight),
                 bins = 40, 
                 fill = "#AA3080", adjust = .2)
