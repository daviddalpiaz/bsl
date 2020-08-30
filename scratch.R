




set.seed(42)
lapply(c(10, 20, 30), rnorm, mean = 4, sd = 5)

set.seed(42)
list(
  rnorm(10, mean = 4, sd = 5),
  rnorm(20, mean = 4, sd = 5),
  rnorm(30, mean = 4, sd = 5)
)








list_of_sims = lapply(c(0.25, 0.5, 0.75, 1), rnorm, n = 100, mean = 0)
sapply(list_of_sims, sd)

