################################################################################

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

################################################################################

sim_2d_logistic = function(beta_0, beta_1, beta_2, n) {

  par(mfrow = c(1, 2))

  prob_plane = as_tibble(expand.grid(x1 = -220:220 / 100,
                                     x2 = -220:220 / 100))
  prob_plane$p = with(prob_plane,
                      boot::inv.logit(beta_0 + beta_1 * x1 + beta_2 * x2))

  do_to_db = colorRampPalette(c('darkorange', "white", 'dodgerblue'))

  plot(x2 ~ x1, data = prob_plane,
       col = do_to_db(100)[as.numeric(cut(prob_plane$p,
                                          seq(0, 1, length.out = 101)))],
       xlim = c(-2, 2), ylim = c(-2, 2), pch = 20)
  abline(-beta_0 / beta_2, -beta_1 / beta_2, col = "black", lwd = 2)

  x1 = runif(n = n, -2, 2)
  x2 = runif(n = n, -2, 2)
  y = rbinom(n = n, size = 1, prob = boot::inv.logit(beta_0 + beta_1 * x1 + beta_2 * x2))
  y = ifelse(y == 1, "dodgerblue", "orange")
  asdf = tibble(x1, x2, y)

  plot(x2 ~ x1, data = asdf, col = y, xlim = c(-2, 2), ylim = c(-2, 2), pch = 20)
  grid()
  abline(-beta_0 / beta_2, -beta_1 / beta_2, col = "black", lwd = 2)

}

sim_2d_logistic(beta_0 = 2 * 0.5, beta_1 = 2* 0.7, beta_2 = 2* 0.5, n = 100)

################################################################################

# Random Forest in R | As Fast as Possible

library(randomForest)
library(mlbench)


set.seed(42)
trn_data = as.data.frame(mlbench::mlbench.spirals(n = 2500, sd = 0.15))
tst_data = as.data.frame(mlbench::mlbench.spirals(n = 2500, sd = 0.15))






plot(x.2 ~ x.1, data = trn_data, col = trn_data$classes, pch = 20)
grid()


mod = randomForest(classes ~ ., data = trn_data)
predict(mod, tst_data, type = "prob")
predict(mod, tst_data)


mean(tst_data$classes == predict(mod, tst_data))


set.seed(42)
trn_data = as.data.frame(mlbench::mlbench.friedman1(n = 250, sd = 1))
tst_data = as.data.frame(mlbench::mlbench.friedman1(n = 250, sd = 1))

pairs(trn_data)

set.seed(42)

mod = randomForest(y ~ ., data = trn_data)
predict(mod, tst_data)


sqrt(mean((tst_data$y - predict(mod, tst_data)) ^ 2))
