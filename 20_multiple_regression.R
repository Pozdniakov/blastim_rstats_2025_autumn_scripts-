library(tidyverse)
data(Backpack)

back <- Backpack %>%
  mutate(backpack_kg = BackpackWeight * 0.453592,
         body_kg = BodyWeight * 0.453592)

model <- lm(backpack_kg ~ body_kg, data = back)

model_multi <- lm(backpack_kg ~ body_kg + Units, data = back)

summary(model)
summary(model_multi)

model_multi_2 <- lm(backpack_kg ~ body_kg + Units + BackProblems + Year, data = back)
summary(model_multi_2)

model_multi_3 <- lm(backpack_kg ~ body_kg + Units + BackProblems, data = back)
summary(model_multi_3)

#install.packages("car")
car::vif(model_multi_3)
