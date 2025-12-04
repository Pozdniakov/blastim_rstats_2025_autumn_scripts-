
# Множественные корреляции ------------------------------------------------


library(tidyverse)
data(Backpack)

back <- Backpack %>%
  mutate(backpack_kg = BackpackWeight * 0.453592,
         body_kg = BodyWeight * 0.453592)

cor.test(back$body_kg, back$BackProblems)
t.test(back$body_kg ~ back$BackProblems, var.equal = TRUE)

back %>%
  select(backpack_kg, body_kg, Year, Units) %>%
  cor()

back %>%
  select(backpack_kg, body_kg, Year, Units) %>%
  psych::corr.test()

as.data.frame(matrix(rnorm(100*20), ncol = 20))

set.seed(42)
spirious <- rnorm(100*20) %>%
  matrix(ncol = 20) %>%
  as.data.frame() %>%
  psych::corr.test(adjust = "bonferroni")
spirious
str(spirious)
sum(spirious$p < 0.05) - 20
(20^ 2 - 20)/2 * .05

back %>%
  select(backpack_kg, body_kg, Year, Units) %>%
  psych::corr.test()

p <- seq(0.0001, 0.06, length.out = 10)
p
p.adjust(p)
p.adjust(p, method = "bonferroni")
p.adjust(p, method = "fdr")
p.adjust(p, method = "BH")


# Хитмап корреляций -------------------------------------------------------

install.packages("corrplot")
library(corrplot)
mtcars %>%
  cor() %>%
  corrplot(method = "color", order = "hclust")

mtcars_cors <- mtcars %>%
  psych::corr.test()
str(mtcars_cors)

corrplot(mtcars_cors$r, p.mat = mtcars_cors$p, method = "color")

install.packages("corrr")
library(corrr)

mtcars %>%
  correlate() %>%
  network_plot(min_cor = 0.7)

# Линейная регрессия ------------------------------------------------------

model <- lm(backpack_kg ~ body_kg, data = back)
model$coefficients
ggplot(back, aes(x = body_kg, y = backpack_kg)) +
  geom_point(alpha = .5) +
  geom_abline(slope = model$coefficients[2],
              intercept = model$coefficients[1])

lm(backpack_kg ~ body_kg, data = back) %>%
  summary()

predict(model, data.frame(body_kg = 1000))

residuals(model)
str(model)
model$residuals
rss <- sum(residuals(model) ^ 2)
tss <- sum((back$backpack_kg - mean(back$backpack_kg))^2)
1 - rss/tss
summary(model)
cor.test(back$body_kg, back$backpack_kg)$estimate ^ 2

mean(residuals(model))
plot(model)

back_no_outliers <- back %>%
  slice(-c(6, 25, 66))

model_without_outliers <- lm(backpack_kg ~ body_kg, data = back_no_outliers)
summary(model_without_outliers)

model_without_outliers$coefficients


ggplot(back, aes(x = body_kg, y = backpack_kg)) +
  geom_point(alpha = .5) +
  geom_point(data = back_no_outliers, colour = "#EE4014") +
  geom_abline(slope = model$coefficients[2],
              intercept = model$coefficients[1]) +
  geom_abline(slope = model_without_outliers$coefficients[2],
              intercept = model_without_outliers$coefficients[1],
              linetype = "dotted")
