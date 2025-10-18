is.vector(list())
is.atomic(list())

# Датафреймы --------------------------------------------------------------

str(list(name = c("Oleg", "Alexander", "Timur", "Daria", "Katya"),
     age = 25:29,
     student = c(TRUE, FALSE, FALSE, TRUE, FALSE)))

str(data.frame(name = c("Oleg", "Alexander", "Timur", "Daria", "Katya"),
         age = 25:29,
         student = c(TRUE, FALSE, FALSE, TRUE, FALSE)))

df <- data.frame(name = c("Oleg", "Alexander", "Timur", "Daria", "Katya"),
                 age = 25:29,
                 student = c(TRUE, FALSE, FALSE, TRUE, FALSE))

as.matrix(df)
df
df$student
df$name
df$age
df[1:2, 1:2]
df[1:5, c("age", "name")]
df[, c("age", "name")]
df[c(1, 3, 5), ]
df[df$age > mean(df$age), ]
df$lovesR <- TRUE
df
df$name[df$student]
df$name[!df$student]
sum(df$student)
mean(df$student)

df$lovesR <- NULL
df

ls()
data(mtcars)
iris

mtcars[c("hp", "mpg", "cyl")]

mat <- matrix(1:12, nrow = 4)
mat[1:6]
mat
mtcars[c("hp", "mpg", "cyl")]

?mean
?median

# Пакеты ------------------------------------------------------------------

install.packages("beepr")
library(beepr)
beep()
beep(11)
beepr::beep()

install.packages("devtools")
devtools::install_github("brooke-watson/BRRR", force = TRUE)

BRRR::skrrrahh(12)
library(BRRR)

install.packages("rdracor")
library(rdracor)
corpora <- get_dracor_meta()
summary(corpora)
#> DraCor hosts 17 corpora comprising 3184 plays.
#> 
#> The last updated corpus was German Drama Corpus (2024-04-03 10:50:28).
plot(corpora)

get_text_df(play = "lessing-emilia-galotti", corpus = "ger")


# Импорт данных -----------------------------------------------------------

read.csv("/Users/ivan/Desktop/heroes_information.csv")
getwd()
read.csv("heroes_information.csv")
read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv")
read.csv2()
?read.csv

read.table("heroes_information.csv", 
           header = TRUE, 
           sep = ",",
           quote = "\"")

heroes <- read.csv("heroes_information.csv", na.strings = c("NA", "-", "-99", ""))
# heroes$Weight[heroes$Weight == -99] <- NA

mean(heroes$Height, na.rm = TRUE)
vroom::vroom("heroes_information.csv")

heroes[1:6,]
head_heroes <- head(heroes)
write.csv(head_heroes, "data/head_heroes.csv")
