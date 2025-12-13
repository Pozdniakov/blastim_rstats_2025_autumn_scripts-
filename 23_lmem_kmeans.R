library(tidyverse)


# LMEM --------------------------------------------------------------------


install.packages("lme4")
install.packages("lmerTest")
library(lme4)
library(lmerTest)

data("sleepstudy")
?sleepstudy

sleepstudy

sleepstudy %>%
  ggplot(aes(x = Days, y = Reaction)) +
  geom_line() + 
  geom_point() +
  facet_wrap(~Subject) +
  scale_x_continuous(breaks = 0:9) +
  theme_minimal()

sleep_lme0 <- lmer(Reaction ~ Days + (1 | Subject), data = sleepstudy)
sleep_lme1 <- lmer(Reaction ~ Days + (Days| Subject), 
                   data = sleepstudy)

sleepstudy$predicted_lme0 <- predict(sleep_lme0)
sleepstudy$predicted_lme1 <- predict(sleep_lme1)

sleepstudy %>%
  rename(observed_RT = Reaction) %>%
  pivot_longer(cols = c(observed_RT, predicted_lme0, predicted_lme1),
               names_to = "model", values_to = "Reaction") %>%
  ggplot(aes(x = Days, y = Reaction, colour = model)) +
  geom_line(alpha = .7) + 
  geom_point(alpha = .5) +
  facet_wrap(~Subject) +
  scale_x_continuous(breaks = 0:9) +
  theme_minimal()

sleep_lme0 %>% summary()
sleep_lme1 %>% summary()

anova(sleep_lme0, sleep_lme1)


# k-means -----------------------------------------------------------------

iris_3means <- iris %>%
  select(!Species) %>%
  scale() %>%
  kmeans(centers = 3)

iris$cluster <- iris_3means$cluster

table(iris$Species, iris$cluster)

plot(iris %>% select(1:4), col = iris$Species, pch = iris$cluster)

plot(iris %>% select(1:4), col = iris$cluster)

iris %>%
  select(!Species) %>%
  scale() %>%
  kmeans(centers = 4)
str(iris_3means)
iris_3means$totss
