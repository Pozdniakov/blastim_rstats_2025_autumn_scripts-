typeof(3 + 1i)
typeof(2)
typeof(4L)
is.integer(4)
is.integer(4L)
is.double(4.5)

s <- "hi, everyone"
s1 <- 'hello'
s
s1
paste("I", "love", "R")
?paste
paste("I", "love", "R", sep = "_<3_*^*&___")
#paste("I", "love", "R", sep = "")
paste0("I", "love", "R")

#t1 <- is.integer(4L)
t1 <- TRUE
f1 <- FALSE

!t1 #FALSE
#!!t1
!f1

t1 & t1 #TRUE
t1 & f1 #FALSE
f1 & t1 #FALSE
f1 & f1 #FALSE

t1 | t1 #TRUE
t1 | f1 #TRUE
f1 | t1 #TRUE
f1 | f1 #FALSE

age <- 25
age >= 18
age < 30
age >= 18 & age < 30
!(age >= 18 & age < 30)
age < 18 | age >= 30

c(4, 8, 15, 16, 23, 42)
c(4, 8)
c("Hello", "everyone")
paste("I", "love", "R")
c("I", "love", "R")
c(TRUE, FALSE)

a <- c(4, 8, 15, 16, 23, 42)
sum(a)
mean(a)
c(a, 100, a)

1:10
5:-3

#10:10:100 #так не работает!
seq(from = 10, to = 100, by = 10)
seq(10, 100, by = 5)
seq(1, 13, length.out = 7)

rep(1, 5)
rep(1:3, 3)
rep(1:3, each = 3)
rep(1:3, c(10, 2, 5))
rep(c("hey", "ho"), 10)

rep(1:9, 1:9)

c(FALSE, 2L)
c(2, "hello")
2 + TRUE
c(TRUE, 3, "hi")
c(c(TRUE, 3), "hi")

as.integer(c(TRUE, FALSE, TRUE))
as.character(c(TRUE, FALSE, TRUE))
as.character(as.integer(c(TRUE, FALSE, TRUE)))

as.numeric(c("1", "2", "три"))

n <- 1:4
m <- c(10, 100, 1000, 10000)
n
m
n + m
m - n
n * m
m / n
m ^ n
n ^ n
n + n ^ n - m / n
sqrt(1:10)
log(1:10)
log(1:10, 2:11)
n * 10
k <- c(10, 100)
n * k
p <- c(10, 100, 1000)
n * p

(1:10) ^ 2

seq(1, 28, by = 3)
cumsum(1:10)
sum(1/(2^(0:20)))
sum(1/((2^0):20))

1:20 * rep(0:1, 10)
1:20 * 0:1

n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n
n[1]
length(n)
n[length(n)]
head(n)
head(n, n = 1)
tail(n)
tail(n, 1)

n[3] <- 20
n
n[4:7]
n[10:1]
rev(n)
n
#`[`(n, 6)
rev(n)
rev_n <- rev(n)
n[4:6] <- 0
n
n[-1]
n[-5]
n[-3:-7]
n
n[c(TRUE, FALSE, TRUE, FALSE, TRUE,
    FALSE, TRUE, FALSE, TRUE, FALSE)]
n[c(TRUE, FALSE)]
n
n[n!=0]
n == 0
n[n == 0]
!n == 0
n[n != 0]
n
n[n > 18]
n >= 18
n <= 30
n[n >= 18 & n <= 30]
my_named_vector <- c(first = 1, second = 2, third = 3)
my_named_vector
attributes(my_named_vector)
names(my_named_vector)
letters
LETTERS
month.abb
month.name
letters[1:3]
names(my_named_vector) <- letters[1:3]
my_named_vector
my_named_vector["b"]
my_named_vector["c", "a"]
my_named_vector[1, 2]
my_named_vector[c("c", "a")]
my_named_vector[c(1, 3)]

names(my_named_vector) <- NULL
my_named_vector
names(my_named_vector) <- letters[1:3]
my_named_vector
attr(my_named_vector, "names") <- NULL
my_named_vector
