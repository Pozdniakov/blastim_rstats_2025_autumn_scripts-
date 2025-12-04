library(tidyverse)
diet <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/stcp-Rdataset-Diet.csv") %>%
  mutate(weight.loss = weight6weeks - pre.weight,
         Dietf = factor(Diet, labels = LETTERS[1:3]),
         Person = factor(Person)) %>%
  drop_na()

aov_model <- aov(weight.loss ~ Dietf, data = diet)
aov_model
class(aov_model)
summary(aov_model)

lm_model <- lm(weight.loss ~ Dietf, data = diet)
summary(lm_model)

pairwise.t.test(diet$weight.loss, diet$Dietf, pool.sd = FALSE)
pairwise.t.test(diet$weight.loss, diet$Dietf)

TukeyHSD(aov_model)

hist(residuals(aov_model))
hist(rnorm(nrow(diet)))
qqnorm(residuals(aov_model))
qqnorm(rnorm(nrow(diet)))

diet %>%
  group_by(Dietf) %>%
  summarise(sd(weight.loss))

diet$residuals <- residuals(aov_model)

diet %>%
  ggplot(aes(x = Dietf, y = residuals)) +
  geom_point(position = position_jitter(width = .1), alpha = .7)

car::leveneTest(weight.loss ~ Dietf, data = diet)

install.packages("ez")
library(ez)

ez_model <- ezANOVA(data = diet,
        dv = weight.loss,
        wid = Person,
        between = Dietf,
        detailed = TRUE,
        return_aov = TRUE)
ez_model

#3x2 ANOVA
#3x3x2 ANOVA

ezANOVA(data = diet,
        dv = weight.loss,
        wid = Person,
        between = .(Dietf, gender),
        detailed = TRUE)

diet %>%
  group_by(Dietf, gender) %>%
  summarise(weight_loss_m = mean(weight.loss)) %>%
  ggplot(aes(x = Dietf,
             y = weight_loss_m,
             colour = as.factor(gender),
             group = as.factor(gender))) +
  geom_line() +
  geom_point()

diet %>%
  mutate(age_group = if_else(Age > median(Age),
                             "old", 
                             "young")) %>%
  ezANOVA(dv = weight.loss,
        wid = Person,
        between = .(Dietf, gender, age_group),
        detailed = TRUE)

dietlong_C <- diet %>%
  filter(Dietf == "C") %>% 
  droplevels() %>%
  pivot_longer(cols = c(pre.weight, weight6weeks),
               names_to = "time",
               values_to = "weight") 

ezANOVA(data = dietlong_C,
        dv = weight,
        wid = Person,
        within = time)

dietlong <- diet %>%
  pivot_longer(
    cols = c(pre.weight, weight6weeks),
    names_to = "time",
    values_to = "weight"
  ) %>%
  mutate(age_group = if_else(Age > median(Age), "old", "young"))

ezANOVA(data = dietlong,
        dv = weight,
        wid = Person,
        within = time,
        between = .(Dietf))

ezANOVA(data = dietlong,
        dv = weight,
        wid = Person,
        within = time,
        between = .(Dietf, gender))

kruskal.test(weight.loss ~ Dietf, data = diet)
friedman.test(weight ~ time | Person, data = dietlong_C)

ez_model <- ezANOVA(data = diet,
                    dv = weight.loss,
                    wid = Person,
                    between = Dietf,
                    detailed = TRUE,
                    return_aov = TRUE)
TukeyHSD(ez_model$aov)

aov(weight.loss ~ Dietf * gender, data = diet) %>% summary()

library(tidyverse)
penguins <- readr::read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/penguins.csv") %>%
  mutate(id = row_number()) #добавляем id

penguins %>%
  group_by(species, sex) %>%
  summarise(across(ends_with("_mm") | ends_with("_g"),
                   mean,
                   na.rm = TRUE))

ez_penguins_species_sex <- penguins %>%
  drop_na(sex) %>%
  ezANOVA(wid = id,
          dv = flipper_length_mm,
          between = .(species, sex),
          return_aov = TRUE)
ez_penguins_species_sex$aov %>%
  TukeyHSD()
