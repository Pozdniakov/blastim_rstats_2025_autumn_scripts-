library(tidyverse)
library(gt)

se <- function(x) sd(x)/sqrt(length(x))
iris %>%
  group_by(Species) %>%
  summarise(across(where(is.numeric),
                   function(x) str_glue("{mean(x)} ± {sd(x)/sqrt(length(x))}")))

iris %>%
  group_by(Species) %>%
  summarise(str_glue("{mean(Sepal.Length) %>% round(2)} ± {se(Sepal.Length) %>% round(2)}"))

iris %>%
  pivot_longer(cols = where(is.numeric)) %>%
  group_by(Species, name) %>%
  summarise(value = str_glue("{mean(value) %>% round(2)} ± {se(value) %>% round(2)}")) %>%
  pivot_wider() %>%
  ungroup() %>%
  gt() %>%
  tab_header(
    title = "Let's uncancel iris!",
    subtitle = "Iris properties, mean ± se"
  ) %>%
  tab_spanner(
    label = "Petal",
    columns = starts_with("Petal")) %>%
  tab_spanner(
    label = "Sepal",
    columns = starts_with("Sepal")) %>%
  cols_label(
    ends_with("Length") ~ "Length",
    ends_with("Width") ~ "Width",
  )
  

            