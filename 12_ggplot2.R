library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv",
                   na = c("-", "-99", "NA", " "))

ggplot() +
  geom_point(data = heroes, aes(x = Height, y = Weight),
             colour = "#7777AA", alpha = 0.5) +
  coord_trans(x = "log10", y = "log10")

count_gender <- heroes %>%
  count(Gender)

ggplot() +
  geom_col(data = count_gender, aes(x = Gender, y = n, fill = Gender))

ggplot() +
  geom_bar(data = heroes, aes(x = Gender, fill = Gender))

ggplot() +
  geom_boxplot(data = heroes, aes(x = Alignment, y = Weight))

ggplot() +
  geom_point(data = heroes, aes(x = Alignment, y = Weight),
             alpha = .5, position = position_jitter(width = .2))



ggplot() +
  geom_bar(data = heroes, aes(x = Gender, fill = Alignment),
           position = "fill")

ggplot() +
  geom_bar(data = heroes, aes(x = Gender, fill = Alignment),
           position = "dodge")


# Many layers -------------------------------------------------------------

ggplot() +
  geom_boxplot(data = heroes, aes(x = Alignment, y = Weight),
               outlier.shape = NA)

ggplot() +
  geom_point(data = heroes, aes(x = Alignment, y = Weight),
             alpha = .5, position = position_jitter(width = .2))

ggplot() +
  geom_violin(data = heroes, aes(x = Alignment, y = Weight))

heroes %>%
  ggplot(aes(x = Alignment, y = Weight, fill = Alignment)) +
  geom_violin(colour = NA) +
  geom_point(alpha = .2, position = position_jitter(width = .3)) +
  geom_boxplot(outlier.shape = NA, width = .1, fill = "white")
  

# "https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/heroes_information.csv" %>%
#   read_csv(na = c("-", "-99", "NA", " ")) %>%
#   filter(Gender == "Female") %>%
#   ggplot(aes(x = Height, y = Weight)) +
#   geom_point()


# Coord -------------------------------------------------------------------

ggplot(data = heroes, aes(x = Height, y = Weight, colour = Gender)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm")
heroes %>%
  drop_na(Race) %>%
  ggplot(aes(x = Race %>% fct_infreq() %>% fct_lump_n(n = 5) %>% fct_rev())) +
  geom_bar() +
  coord_flip()

ggplot() +
  geom_bar(data = heroes, aes(x = "", fill = Gender)) +
  coord_polar(theta = "y")


# Scales ------------------------------------------------------------------

heroes %>%
  ggplot(aes(x = Alignment, y = Weight, fill = Alignment)) +
  geom_violin(colour = NA) +
  # geom_point(alpha = .2, position = position_jitter(width = .3)) +
  geom_boxplot(outlier.shape = NA, width = .1, fill = "white") +
  scale_fill_brewer(palette = "Set1")

heroes %>%
  ggplot(aes(x = Height, y = Weight, size = Weight, colour = Weight)) +
  geom_point() +
  scale_colour_viridis_c(option = "A")


# Facets ------------------------------------------------------------------

heroes %>%
  ggplot(aes(x = Height, y = Weight, size = Weight, colour = Weight)) +
  geom_point() +
  scale_colour_viridis_c(option = "A") +
  facet_wrap(~Gender)

ggplot(data = heroes, aes(x = Height, y = Weight, colour = Gender)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") +
  facet_wrap(~Gender, nrow = 3, scales = "free_y")

ggplot(data = heroes, aes(x = Height, y = Weight, colour = Gender)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm")
heroes %>%
  drop_na(Race) %>%
  ggplot(aes(x = Race %>% fct_infreq() %>% fct_lump_n(n = 10) %>% fct_rev())) +
  geom_bar() +
  coord_flip() +
  facet_wrap(~Gender)


# themes and labs ---------------------------------------------------------

heroes %>%
  ggplot(aes(x = Alignment, y = Weight, fill = Alignment)) +
  geom_violin(colour = NA) +
  # geom_point(alpha = .2, position = position_jitter(width = .3)) +
  geom_boxplot(outlier.shape = NA, width = .1, fill = "white") +
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(~Gender) +
  labs(title = "How heavy are superheroes?",
       subtitle = "Male superheroes have more variety in their weight",
       caption = "Blastim, 2025",
       x = "",
       y = "Weight, kg") +
  theme_linedraw()

ggplot() +
  geom_bar(data = heroes, aes(x = Gender, fill = Alignment),
           position = "dodge") +
  theme_classic()

heroes %>%
  ggplot(aes(x = Alignment, y = Weight, fill = Alignment)) +
  geom_violin(colour = NA) +
  # geom_point(alpha = .2, position = position_jitter(width = .3)) +
  geom_boxplot(outlier.shape = NA, width = .1, fill = "white") +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal()

ggplot() +
  geom_bar(data = heroes, aes(x = "", fill = Gender)) +
  coord_polar(theta = "y") +
  theme_void()

heroes %>%
  ggplot(aes(x = Alignment, y = Weight, fill = Alignment)) +
  geom_violin(colour = NA) +
  # geom_point(alpha = .2, position = position_jitter(width = .3)) +
  geom_boxplot(outlier.shape = NA, width = .1, fill = "white") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "How heavy are superheroes?",
       subtitle = "Male superheroes have more variety in their weight",
       caption = "Blastim, 2025",
       x = "",
       y = "Weight, kg") +
  hrbrthemes::theme_ipsum()
