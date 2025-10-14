n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n + n
n * 10
n
mean(n) #we calculate mean!
n[mean(n)]
n > mean(n)

n[n > mean(n)]

n * (n > mean(n))


# 2468... -----------------------------------------------------------------

seq(2, 20, 2)
1:10 * 2
seq(2, 20, length.out = 10)
(1:20)[c(FALSE, TRUE)] 
c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)

v <- 1:20
v[v %% 2 == 0]


# Логические векторы ------------------------------------------------------

eyes <- c("green", "blue", "blue", "brown", "green", "blue")
eyes
length(eyes[eyes == "blue"])
sum(eyes == "blue")
#sum(eyes == "blue")/length(eyes == "blue")
mean(eyes == "blue")

all(eyes == "blue")
any(eyes == "blue")
any(!eyes == "blue")

which(eyes == "blue")
1:length(eyes)
seq_len(60)
seq_along(eyes)
eyes[eyes == "blue"]

eyes == "blue" & eyes == "green"

eyes[eyes == "blue" | eyes == "green"]

# eyes[eyes == c("green", "blue")] #совсем не то, что нужно

eyes %in% c("green", "blue")

big_cities <- c("Москва", "Санкт-Петербург", "Новосибирск", "Казань", "Екатеринбург")

respondents <- c("Москва", "Москва", "Новосибирск", "Балашиха", "Красногорск", 
                 "Звенигород", "Дубна", "Москва", "Пояконда")
respondents[respondents %in% big_cities]


# NA, NaN, NULL -----------------------------------------------------------

missed <- NA
missed == "NA"
missed == 0
missed == ""
length(missed)
missed == NA

n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n[5] <- NA
mean(n)
n
n == NA
NA == NA
Joe <- NA
Mary <- NA
Joe == Mary
n == NA
is.na(n)
mean(n)
mean(n[!is.na(n)])
mean(n)
n
#n[-5]
mean(n, na.rm = TRUE)
typeof(NA)
typeof(n)
NA_real_
NA_integer_
as.character(n)
NA_character_
NA #Not Available
NaN #Not a Number
1 / 0
-1 / 0
0 / 0

mean(c(NA, NA, NA), na.rm = TRUE)

character()
m <-  1:5
m[m > 6]

NULL
typeof(NULL)
length(NULL)
n[100]
n[1:20]
letters[1:100]

NA ^ 0
NA & FALSE
NA | TRUE
is.nan(0/0)
is.nan(NaN)
is.nan(NA)
is.na(NA)
is.na(NaN)

# Matrix ------------------------------------------------------------------


matrix(1:12, nrow = 4, ncol = 3)
A <- matrix(1:12, nrow = 4)
A[2, 3]
A[2:3, 1:2]
A[c(1, 3), c(1, 3)]
A[c(TRUE, FALSE, FALSE, TRUE), c(FALSE, TRUE, TRUE)]
A[A > 10]
A[1:2, 1:2] <- 100
A
attributes(A)
attr(A, "dim") <- NULL
A
attr(A, "dim") <- c(2, 6)
A
attr(A, "dim") <- c(3, 2, 2)
A

matrix(rep(1:9, 9), nrow = 9)
rep(1:9, each = 9)
matrix(1:9 * rep(1:9, each = 9), nrow = 9)
outer(1:9, 1:9, `*`)
1:9 %o% 1:9

# Lists -------------------------------------------------------------------

simple_list <- list(42, "Hello", TRUE)
simple_list
complex_list <- list(simple_list,
     1:10,
     letters,
     A,
     mean,
     `[`)
complex_list
str(complex_list)

named_list <- list(name = "Veronika", age = 30, student = TRUE)
named_list
named_list$name
named_list[1]
typeof(named_list$name)
typeof(named_list[1])
named_list[[1]]
named_list
#Список длиной 1 из элемента 2
named_list[2]
named_list["age"]
#Содержимое элемента 2
named_list[[2]]
named_list[["age"]]
named_list$age

simple_list

attributes(named_list)

list1 <- list(numbers = 1:5, letters = letters, logic = TRUE)
list1
list2 <- list(pupa = list1, lupa = list1)
list2[[1]][[2]][3]
