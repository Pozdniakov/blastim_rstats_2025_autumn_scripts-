library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

heroes %>%
  distinct()

heroes %>%
  distinct(Gender, Alignment)

heroes %>%
  count(Gender, Alignment)

#install.packages("janitor")
library(janitor)
heroes %>%
  get_dupes()

heroes %>%
  get_dupes(name)

heroes %>%
  group_by(name) %>%
  slice(1) %>%
  ungroup()
