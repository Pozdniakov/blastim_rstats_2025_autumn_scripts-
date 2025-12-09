library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

heroes$is_good <- heroes$Alignment == "good"

heroes_selected <- heroes %>%
  drop_na(is_good, Gender, Weight)

heroes_good_glm <- glm(is_good ~ Weight + Gender,
                       heroes_selected,
                       family = binomial())
summary(heroes_good_glm)

heroes_good_without_weight_glm <- glm(is_good ~ Gender,
                                      heroes_selected, 
                                      family = binomial())
summary(heroes_good_without_weight_glm)

report::report(heroes_good_glm)
?report::report

heroes_selected$predicted_alignment <- 
  if_else(predict(heroes_good_glm, type = "response") > 0.5,
          "predicted_good",
          "predicted_bad")

table_heroes <- table(heroes_selected$is_good,
      heroes_selected$predicted_alignment)
sum(diag(table_heroes))/sum(table_heroes)
