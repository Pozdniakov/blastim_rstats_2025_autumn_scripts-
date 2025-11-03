library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

# across() ----------------------------------------------------------------


heroes %>%
  group_by(Gender) %>%
  summarise(height = mean(Height, na.rm = TRUE),
            weight = mean(Weight, na.rm = TRUE))

heroes %>%
  group_by(Gender) %>%
  summarise(across(c(Height, Weight), mean, na.rm = TRUE))

heroes %>%
  group_by(Gender) %>%
  summarise(across(c(Height, Weight), function(x) mean(x, na.rm = TRUE)))

heroes %>%
  group_by(Gender) %>%
  summarise(across(where(is.numeric), function(x) mean(x, na.rm = TRUE)))

heroes %>%
  group_by(Gender) %>%
  summarise(across(where(is.character), function(x) mean(nchar(x), na.rm = TRUE) ))

heroes %>%
  group_by(Gender) %>%
  summarise(
    across(where(is.numeric), function(x) mean(x, na.rm = TRUE)),
    across(where(is.character), function(x) mean(nchar(x), na.rm = TRUE) ))

heroes %>%
  drop_na(Height, Weight) %>%
  group_by(Gender) %>%
  summarise(across(c(Height, Weight), list(minimum = min,
                                           average = mean,
                                           maximum = max)))

heroes %>%
  mutate(Gender = as.factor(Gender))

heroes %>%
  mutate(across(where(is.character), as.factor))
heroes %>%
  mutate(across(where(is.numeric), as.character))
iris %>%
  mutate(across(!Species, function(x) x/max(x) * 100))


# list columns/nesting ----------------------------------------------------

nested_heroes <- heroes %>%
  nest(!Gender)

heroes %>%
  group_by(Gender) %>%
  nest()

heroes %>%
  nest(data = !Gender) %>%
  mutate(dims = map(data, dim)) %>%
  select(!data) %>%
  unnest(cols = dims)

heroes %>%
  nest(data = !Gender) %>%
  mutate(dims = map(data, dim)) %>%
  select(!data) %>%
  unnest_wider(dims, names_sep = "_")

films <- tribble(
  ~film, ~genres,
  "The Green Elephant", "Art-House, Drama, Comedy",
  "Clerks", "Comedy",
  "Superbad", "Comedy",
  "Harry Potter 1", "Action, Family, Fantasy"
)
# films %>%
#   filter(genres == "Comedy")
# films %>%
#   filter(str_detect(genres, "Comedy"))

str_split(films$genres, pattern = ", ")

films %>%
  mutate(genres = str_split(genres, pattern = ", ")) %>%
  unnest() %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = genres,
              values_from = value,
              values_fill = FALSE)

films %>%
  separate_longer_delim(genres, delim = ", ") %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = genres,
              values_from = value,
              values_fill = FALSE)  
