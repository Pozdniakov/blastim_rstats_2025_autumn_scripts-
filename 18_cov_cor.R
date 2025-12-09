library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

gender_publisher <- heroes %>%
  drop_na(Gender) %>%
  filter(Publisher %in% c("Marvel Comics", "DC Comics")) %>%
  select(Gender, Publisher)

table(gender_publisher)

61 / (61 + 153)
111 / (111 + 252)

61/ (61 + 111)
153/(153 + 252)

table_gp <- table(gender_publisher)
attributes(table_gp)
attr(table_gp, "class") <- NULL
attributes(table_gp) <- NULL
table_gp

table(gender_publisher) %>% summary()
table(gender_publisher) %>% chisq.test()
table(gender_publisher) %>% fisher.test()

table(gender_publisher) %>% mosaicplot(shade = TRUE,
                                       color = TRUE)

pub_good <- heroes %>%
  filter(Alignment %in% c("good", "bad")) %>%
  select(Alignment, Gender) %>%
  drop_na()

table(pub_good)
mosaicplot(table(pub_good), shade = TRUE, color = TRUE)
options(scipen = 999)
table(pub_good) %>% chisq.test()

heroes$is_human <- heroes$Race == "Human"

heroes %>%
  group_by(is_human) %>%
  summarise(mean(Gender == "Female", na.rm = TRUE))

table(heroes$Gender, heroes$is_human) %>% chisq.test()
table(heroes$Gender, heroes$is_human) %>%
  mosaicplot(shade = TRUE, color = TRUE)


# Ковариация и корреляция -------------------------------------------------

install.packages("Stat2Data")
library(Stat2Data)
data(Backpack)

back <- Backpack %>%
  mutate(backpack_kg = BackpackWeight * 0.453592,
         body_kg = BodyWeight * 0.453592)

plot(back$body_kg, back$backpack_kg)

cov(back$backpack_kg, back$body_kg)
back %>%
  select(backpack_kg, body_kg) %>%
  cov()

back %>%
  select(backpack_kg, body_kg) %>%
  var()

back %>%
  select(BackpackWeight, BodyWeight) %>%
  cov()

cor(back$BodyWeight, back$body_kg)
plot(back$BodyWeight, back$body_kg)

body_kg_z <- (back$body_kg - mean(back$body_kg))/sd(back$body_kg)
(back$BodyWeight - mean(back$BodyWeight))/sd(back$BodyWeight)
z <- function(x) (x - mean(x))/sd(x)
var(z(back$body_kg), z(back$backpack_kg))
back %>%
  select(body_kg, backpack_kg) %>%
  cor()

cor.test(back$body_kg, back$backpack_kg)
cor.test(back$body_kg, back$backpack_kg, method = "spearman")
cor.test(back$body_kg, back$backpack_kg, method = "kendall")

cor.test(back$body_kg, back$backpack_kg)
cor.test(back$BodyWeight, back$BackpackWeight)

cor.test(heroes$Height, heroes$Weight)
cor.test(heroes$Height, heroes$Weight, method = "spearman")
cor.test(heroes$Height, heroes$Weight, method = "kendall")

plot(heroes$Height, heroes$Weight)

heroes_no_outliers <- heroes %>%
  filter(Height < 600)

cor.test(heroes_no_outliers$Height, 
         heroes_no_outliers$Weight,
         method = "spearman")

cor.test(heroes_no_outliers$Height, 
         heroes_no_outliers$Weight,
         method = "kendall")

cor.test(heroes_no_outliers$Height, 
         heroes_no_outliers$Weight,
         method = "pearson")
