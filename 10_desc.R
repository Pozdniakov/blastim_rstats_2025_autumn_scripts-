library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))
heroes %>%
  select(ends_with("color"))

weight <- heroes %>%
  drop_na(Weight) %>%
  pull(Weight)

mean(weight)
mean(c(weight, 100500))

median(weight)
median(c(weight, 100500))
sort(weight)

heroes %>%
  count(Weight, sort = TRUE)

heroes %>%
  count(`Eye color`, sort = TRUE)
?mean

mean(weight, trim = 0.1)
mean(weight)
median(weight)

mean(c(weight, 100500), trim = 0.1)
mean(weight, trim = 0.5)
