library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))


# Создание колонок и условные конструкции (продолжение) -------------------


numbers <- -2:2
numbers
if_else(numbers > 0, "Positive number", "Negative number or zero")
if_else(numbers > 0, 
        "Positive number", 
        if_else(numbers < 0, 
                "Negative number",
                "Zero"))

case_when(numbers > 0 ~ "Positive number", #if
          numbers < 0 ~ "Negative number", #else if
          TRUE ~ "zero" #else
          )

case_when(numbers > 0 ~ "Positive number", #if
          numbers < 0 ~ "Negative number", #else if
          .default = "zero" #else
)

heroes %>%
  mutate(imt = Weight/(Height/100)^2, .before = Race) %>%
  mutate(imt_group = case_when(is.na(imt) ~ NA_character_,
                               imt > 40 ~ "overweight",
                               imt > 30 ~ "slightly overweight",
                               imt < 18.5 ~ "underweight",
                               .default = "normal weight"
                               ),
         .after = imt)


heroes %>%
  mutate(imt = Weight/(Height/100)^2,
         imt_group = case_when(is.na(imt) ~ NA_character_,
                               imt > 40 ~ "overweight",
                               imt > 30 ~ "slightly overweight",
                               imt < 18.5 ~ "underweight",
                               .default = "normal weight"),
          .after = name)

heroes %>%
  transmute(imt = Weight/(Height/100)^2, name, Race, Publisher)

heroes %>%
  transmute(name,
            `Hair color`,
            hair = if_else(`Hair color` == "No Hair", "bold", "hairy"))


# Аггрегация --------------------------------------------------------------

heroes %>%
  summarise(mean_height = mean(Height, na.rm = TRUE))

heroes %>%
  mutate(mean_height = mean(Height, na.rm = TRUE))

heroes %>%
  summarise(first = first(Height), 
            last = last(Height),
            tenth = nth(Height, 10))

# heroes %>%
#   summarise(first = Height[1], 
#             last = Height[length(Height)],
#             tenth = Height[10])

heroes %>%
  summarise(range(Height, na.rm = TRUE))

heroes %>%
  reframe(range(Height, na.rm = TRUE))

heroes %>%
  group_by(Gender)

heroes %>%
  group_by(Gender) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE))

heroes %>%
  group_by(Alignment, Gender) %>%
  summarise(first = first(Height), 
            last = last(Height),
            tenth = nth(Height, 10))

heroes %>%
  group_by(Gender, Weight > 100) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE))

heroes %>%
  group_by(Gender, Weight > 100) %>%
  reframe(range(Height, na.rm = TRUE))

heroes %>%
  group_by(Gender) %>%
  summarise(n = n())

heroes %>%
  count(Gender)

heroes %>%
  count(Race, sort = TRUE) %>% View()

heroes %>%
  count(Gender, Alignment, sort = TRUE)

heroes %>%
  group_by(Gender) %>%
  transmute(name, Gender, Height,
         mean_height_by_gender = mean(Height, na.rm = TRUE),
         height_diff_gender = Height - mean_height_by_gender)

heroes %>%
  group_by(Race) %>%
  filter(n() > 10)

heroes %>%
  group_by(Race) %>%
  filter(n() == 1)  


# Соединение датафреймов/тибблов ------------------------------------------

band_members
band_instruments

bind_cols(band_members, band_instruments)
bind_rows(band_members, band_instruments)

list_of_df <- list(members = band_members,
                   instruments = band_instruments)
bind_rows(list_of_df, .id = "from")

left_join(band_members, band_instruments)
band_members %>%
  left_join(band_instruments)
names(band_members)
names(band_instruments)
?intersect
intersect(names(band_members), names(band_instruments))
band_instruments2
left_join(band_members, band_instruments2, by = c("name" = "artist"))
left_join(band_members, band_instruments, by = "name")

band_members %>%
  right_join(band_instruments)

band_instruments %>%
  left_join(band_members)

band_members %>%
  full_join(band_instruments)

band_members %>%
  inner_join(band_instruments)

# band_members %>%
#   filter(name %in% band_instruments$name)
band_members %>%
  semi_join(band_instruments)

# band_members %>%
#   filter(!name %in% band_instruments$name)
band_members %>%
  anti_join(band_instruments)
band_instruments %>%
  anti_join(band_members)

powers <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/super_hero_powers.csv")

heroes %>%
  semi_join(powers %>% filter(`Web Creation`), by = c("name" = "hero_names"))

heroes %>%
  anti_join(powers, by = c("name" = "hero_names")) %>%
  pull(name)

powers %>%
  anti_join(heroes, by = c("hero_names" = "name")) %>%
  pull(hero_names)


# long and wide data ------------------------------------------------------

new_diet <- tribble(
  ~student, ~before_r_course, ~after_r_course,
  "Sara", 67, 54,
  "Iosif", 89, 82,
  "Svetlana", 76, 59
)

new_diet %>%
  mutate(diff = before_r_course - after_r_course)
pivot_longer
pivot_wider

new_diet %>%
  pivot_longer(cols = before_r_course:after_r_course,
               names_to = "time",
               values_to = "weight") %>%
  pivot_wider(names_from = "time",
              values_from = "weight")
