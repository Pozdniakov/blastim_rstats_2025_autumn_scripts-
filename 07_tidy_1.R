library(tidyverse)

# пайпы -------------------------------------------------------------------


sum(log(abs(sin(1:22))))

1:22 %>% 
  sin() %>% 
  abs() %>% 
  log(x = 2, base = .) %>% 
  sum()

1:22 |>
  sin() |>
  abs() |>
  log(x = 2, base = _) |>
  sum()

c("Корень из", 2, "равен", sqrt(2))
2 %>%
  c("Корень из", ., "равен", sqrt(.))

B <- matrix(10:39, nrow = 5)
apply(B, 1, mean)
10:39 %>%
  matrix(nrow = 5) %>%
  apply(1, mean)

# работа с колонками ------------------------------------------------------


heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

selected_columnns <- heroes %>%
  select(1, 5)
select(heroes, 1, 5)
heroes

heroes %>%
  select(name, Race, Publisher, `Hair color`)

heroes %>%
  select(name:Publisher)

heroes %>%
  select(name:`Eye color`, Publisher:Weight)

heroes %>%
  select(!...1)

heroes %>%
  select(!(Gender:Height))

heroes %>%
  select(name:last_col())

heroes %>%
  select(everything())

heroes %>%
  select(name, Publisher, everything())

heroes %>%
  select(ends_with("color"))

heroes %>%
  select(starts_with("H"))
heroes %>%
  select(starts_with("H") & ends_with("color"))
heroes %>%
  select(starts_with("H") | ends_with("color"))

heroes %>%
  select(contains("eigh"))
heroes %>%
  select(matches("[HW]eight"))
heroes %>%
  select(where(is.numeric))
heroes %>%
  select(where(is.character))

heroes %>%
  select(where(function(x) !any(is.na(x)) ))

heroes %>%
  select(where(function(x) mean(is.na(x)) < .1 ))

heroes %>%
  select(id = ...1)

heroes %>%
  rename(id = ...1)

heroes %>%
  rename_with(toupper)
#names(heroes) <- toupper(names(heroes))

heroes %>%
  rename_with(tolower)

heroes %>%
  rename_with(make.names)

heroes %>%
  relocate(Publisher, name)

heroes %>%
  relocate(name, where(is.numeric), Publisher)

heroes %>%
  relocate(Publisher, where(is.numeric), .after = name)
heroes %>%
  relocate(Universe = Publisher, where(is.numeric), .before = Race)

heroes %>%
  select(name)

mtcars[,2, drop = FALSE]
heroes %>%
  select(name)
heroes %>%
  select(2)

heroes %>%
  select(name) %>%
  pull()

heroes %>%
  pull(name)

heroes %>%
  pull(Height, name)


# работа со строками ------------------------------------------------------

heroes %>%
  slice(1:6)
heroes %>%
  slice(1, 100, 500)

heroes %>%
  filter(Publisher == "DC Comics")
heroes %>%
  filter(Height < 50 | Height > 500)
heroes %>%
  filter(Height < 100 & Gender == "Female")
heroes %>%
  filter(Height < 100, Gender == "Female")
heroes %>%
  filter(Height < 100) %>%
  filter(Gender == "Female")

heroes %>%
  slice_max(Weight, n = 10, with_ties = FALSE) 

heroes %>%
  slice_min(Weight, n = 10, with_ties = FALSE) 

heroes %>%
  slice_sample(n = 3)
heroes %>%
  slice_sample(prop = .01)
heroes %>%
  slice_sample(prop = 1)
heroes %>%
  drop_na()
heroes %>%
  drop_na(Weight, Height)
heroes %>%
  drop_na(where(is.numeric))

heroes %>%
  select(6:last_col())
heroes %>%
  select(30:40)
heroes %>%
  slice(500:509)
heroes %>%
  slice(seq(1, 701, by = 100))

heroes %>%
  arrange(Weight)
heroes %>%
  arrange(-Weight)
heroes %>%
  arrange(desc(Weight))
heroes %>%
  arrange(desc(Race), Weight)


# Создание колонок --------------------------------------------------------

heroes_with_new_column <- heroes %>%
  mutate(imt = Weight/(Height/100)^2)

numbers <- -2:2
# if (numbers > 0) {
#   "Положительное число"
# } else if (numbers < 0){
#   "Отрицательное число"
# } else {
#   "Ноль"
# }

#ifelse()
numbers
if_else(numbers > 0, "Positive number", "negative number or zero")
