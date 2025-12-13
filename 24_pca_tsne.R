install.packages("factoextra")
install.packages("Rtsne")

library(tidyverse)
mnist_small <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/mnist_small.csv")
penguins <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/penguins.csv") %>%
  drop_na()

iris_scaled <- iris %>%
  select(!Species) %>%
  scale()

kmeans(iris_scaled, centers = 3) %>% str()
map(1:15, function(x) kmeans(iris_scaled, centers = x, nstart = 10, iter.max = 100)) %>%
  map_dbl(function(x) 1 - x$betweenss/x$totss) %>% plot(type = "o")

# mtcars %>%
#   mutate(across(where(is.numeric), function(x) (x - mean(x))/sd(x) ))

mtcars %>%
  scale() %>%
  t() %>%
  dist() %>%
  hclust() %>% plot()


# PCA ---------------------------------------------------------------------

iris %>% plot()
penguins %>%
  select(bill_length_mm:body_mass_g) %>%
  plot(col = as.factor(penguins$species) )

penguins_prcomp <- penguins %>%
  select(bill_length_mm:body_mass_g) %>%
  #scale() %>%
  prcomp(center = TRUE, scale. = TRUE)

str(penguins_prcomp)
penguins_prcomp
penguins_prcomp$x
summary(penguins_prcomp)
plot(penguins_prcomp)
plot(penguins_prcomp$x[,1:2],
     col = as.factor(penguins$species))

plot(penguins_prcomp$x[,3:4],
     col = as.factor(penguins$species))

library(factoextra)
fviz_pca_ind(penguins_prcomp,
             habillage = penguins$species,
             addEllipses = TRUE,
             repel = TRUE)

fviz_pca_var(penguins_prcomp, axes = c(3, 4))

fviz_pca_biplot(penguins_prcomp,
                habillage = penguins$species,
                addEllipses = TRUE,
                repel = TRUE,
                geom = "point")

mnist_pca <- mnist_small %>%
  select(!label) %>%
  select(where(function(x) !all(x == 0) )) %>%
  prcomp(center = TRUE, scale. = TRUE)

pca_df <- mnist_pca$x[,1:2] %>%
  as_tibble() %>%
  bind_cols(label = mnist_small$label) %>%
  slice_sample(prop = .2)


pca_df %>%
  ggplot() +
  geom_text(aes(x = PC1,
                y = PC2,
                label = label,
                colour = as.factor(label))) +
  guides(colour = "none") +
  theme_minimal()

library(Rtsne)
set.seed(42)
tsne <- mnist_small %>%
  select(!label) %>%
  Rtsne(perplexity = 500)

tsne$Y %>%
  bind_cols(label = mnist_small$label) %>%
  rename(x = ...1, y = ...2) %>%
  slice_sample(prop = .2) %>%
  ggplot() +
  geom_text(aes(x = x,
                y = y,
                label = label,
                colour = as.factor(label))) +
  guides(colour = "none") +
  theme_minimal()


# Optional stopping -------------------------------------------------------

set.seed(43)
v <- rnorm(1000)

t.test(head(v, 40))

sum(map_dbl(30:1000, function(x) t.test(head(v, x))$p.value) < 0.05)

set.seed(47)
v <- rnorm(1000)
all_p <- tibble(
  n = 30:1000,
  p = map_dbl(n, function(x)
    t.test(head(v, x))$p.value),
  signif = p < .05
)

ggplot(all_p, aes(x = n, y = p)) +
  geom_hline(yintercept = .05, linetype = "dashed") +
  geom_line() +
  geom_point(aes(colour = signif)) +
  coord_cartesian(ylim = c(0, 1)) +
  theme_minimal()

replications <- replicate(1000, {
  vv <- rnorm(1000)
  any(map_lgl(30:1000, function(x) t.test(head(vv, x))$p.value < .05))
})
mean(replications)

n_start <- 30
step <- 5
n_stop <- 50
seq(n_start, n_stop, by = step)
replications <- replicate(1000, {
  vv <- rnorm(n_stop)
  vv2 <- rnorm(n_stop)
  any(map_lgl(seq(n_start, n_stop, by = step), function(x) t.test(head(vv, x), head(vv2, x))$p.value < .05))
})
mean(replications)


