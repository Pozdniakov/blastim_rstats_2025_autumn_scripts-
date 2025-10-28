list(mean, `+`, `[`)

A <- matrix(1:12, 3)
A
rowSums(A)
rowMeans(A)
colSums(A)
colMeans(A)

apply(A, 1, sum)
apply(A, 1, mean)
apply(A, 2, sum)
apply(A, 2, mean)

A[2, 2] <- NA
apply(A, 1, mean, na.rm = TRUE)
sum_of_squares <- function(x) sum((x - mean(x, na.rm = TRUE))^2, na.rm = TRUE)
apply(A, 1, sum_of_squares)
apply(A, 1, function(x) sum((x - mean(x, na.rm = TRUE))^2, na.rm = TRUE))

B <- matrix(c("Welcome", "to", "the", "matrix", "Neo", "!"), 3)
mean(nchar(c("Welcome", "to", "the", "matrix", "Neo", "!")))

apply(B, 1, function(x) mean(nchar(x)))
apply(B, 2, \(wtf) mean(nchar(wtf)))

some_list <- list(some = 1:10, list = letters)
length(some_list)
lapply(some_list, length)

sapply(some_list, length)
logs <- log(1:10000000)
logs <- sapply(1:10000000, log)

factors <- function(x) which(x %% seq_len(x) == 0)
factors(10)
is_prime <- function(x) length(factors(x)) == 2
is_prime(1:10)
is_prime_vectrorized <- Vectorize(is_prime)
is_prime_vectrorized(1:10)
sapply(1:10, is_prime)

heroes <- read.csv("heroes_information.csv", na.strings = c("NA", "-", "-99", ""))
typeof(heroes)
class(heroes)
sapply(heroes, typeof)
many_means <- replicate(1000, mean(rlnorm(30)))
hist(many_means)

install.packages("purrr")
library(purrr)

lapply(some_list, length)
map(some_list, length)
map_int(some_list, length)
map_chr(some_list, length)
map(some_list, 2)
some_list

list3 <- list(
  a = 1:5,
  b = 0:20,
  c = 4:24,
  d = 6:3,
  e = 6:25
)

max_item <- function(x) x[[which.max(sapply(x, length))]]
max_item(some_list)
max_item(list3)

table(heroes$Gender)

# подход data.table -------------------------------------------------------


install.packages("data.table")
library(data.table)

heroes_dt <- fread("heroes_information.csv", na = c("NA", "-", "-99", ""))
heroes_dt
class(heroes_dt)
attributes(heroes_dt)
print(heroes_dt)
heroes_dt
methods(print)
str(heroes_dt)

heroes_dt[Alignment == "good",
          .(mean_Height = mean(Height, na.rm = TRUE)),
          by = Gender][order(-mean_Height),]


# подход tidyverse --------------------------------------------------------

install.packages("tidyverse")
library(tidyverse)

gender_factor <- as.factor(heroes$Gender)
str(gender_factor)
attributes(gender_factor)
attributes(gender_factor) <- NULL
gender_factor
gender_factor <- as.factor(heroes$Gender)
as.character(gender_factor)

heroes_tbl <- read_csv("heroes_information.csv", na = c("NA", "-", "-99", ""))
class(heroes_tbl)
heroes_tbl

heroes_tbl %>%
  filter(Alignment == "good") %>%
  group_by(Gender) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE)) %>%
  arrange(desc(mean_height))
