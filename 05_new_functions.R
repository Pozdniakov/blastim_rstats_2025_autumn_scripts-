pow <- function(x, p) {
  power <- x ^ p
  return(power)
}
pow(3, 2)

pow <- function(x, p) {
  x ^ p
}
pow(10, 3)

pow <- function(x, p) x ^ p

pow(5, 3)

pow <- function(x, p = 2) x ^ p
pow(11)
pow(x = 11, p = 4)
mean(1:10)

80/1.84 ^ 2 
weight <- 75
height <-  1.64
weight/height ^ 2
imt <- function(w, h) w/h ^ 2
imt(50, 1.5)

factors <- function(x) which(x %% seq_len(x) == 0)
factors(2025)

is_prime <- function(x) length(factors(x)) == 2
is_prime(100)

pow <- function(x, 
                p, 
                whatever = paste("Число", x, 
                                 "в степени", p, 
                                 "равняется:", power)) {
  power <- x ^ p
  whatever
}
pow(10, 3)
