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


################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################





################################################################################



# note about confusion matrix from caret
# note about yardstick, yeah maybe just a note about it.....
# https://yardstick.tidymodels.org/
# also a note about tidymodels
# do yardsitck AND cvms???? and caret??? ehhh.....




# ml systems to consider
## caret
## tidymodels
## mlr3
## cvms
## ????



################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################


# load packages
library("tidyverse")
library("rpart")

# set seed
set.seed(122)

# load dataset
data(GermanCredit, package = "caret")
gc = as_tibble(GermanCredit)

# test-train split
gc_trn_idx = sample(nrow(gc), size = 0.6 * nrow(gc))
gc_trn = gc[gc_trn_idx, ]
gc_tst = gc[-gc_trn_idx, ]

# check data
head(gc_trn)

# Bad  | Y = 0 | Positive
# Good | Y = 1 | Negative

# manual procedure

mod = rpart(Class ~ ., data = gc_trn)
# prob = predict(mod, gc_tst)[, "Good"]
# pred = factor(ifelse(prob > 0.2, "Good", "Bad"))

prob = predict(mod, gc_tst)[, "Bad"]
pred = factor(ifelse(prob > 0.8, "Bad", "Good"))

# false positive, FP, actual == "Negative", predicted == "Positive"
# false positive, FP, actual == "Good", predicted == "Bad"

fp = sum(gc_tst$Class == "Good" & pred == "Bad")
tp = sum(gc_tst$Class == "Bad" & pred == "Bad")
fn = sum(gc_tst$Class == "Bad" & pred == "Good")
tn = sum(gc_tst$Class == "Good" & pred == "Good")

c(fp = fp, tp = tp, fn = fn, tn = tn)
nrow(gc_tst)

(ppv = tp / (fp + tp))
(fdr = fp / (fp + tp))

# cvms::evaluate

library(cvms)

mod = rpart(Class ~ ., data = gc_trn)
prob = predict(mod, gc_tst)[, "Good"]

results = tibble(
  actual = gc_tst$Class,
  prob = prob
)

eval_res = evaluate(
  data = results,
  target_col = "actual",
  prediction_cols = "prob",
  type = "binomial",
  cutoff = 0.2,
  positive = "Bad"
)

eval_res$`Pos Pred Value`
1 - eval_res$`Pos Pred Value`

eval_res$`Confusion Matrix`

# caret::confusionMatrix

library(caret)

mod = rpart(Class ~ ., data = gc_trn)
# prob = predict(mod, gc_tst)[, "Bad"]
# pred = factor(ifelse(prob > 0.8, "Bad", "Good"))

prob = predict(mod, gc_tst)[, "Good"]
pred = factor(ifelse(prob > 0.2, "Good", "Bad"))


caret_res = confusionMatrix(
  data = pred,
  reference = gc_tst$Class,
  positive = "Bad"
)

caret_res$byClass








################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################




# function to simulate some data
gen_sim_data = function(sample_size) {
  x = runif(n = sample_size, min = -1, max = 1)
  y = rnorm(n = sample_size, mean = x ^ 3, sd = 0.25)
  tibble::tibble(x, y)
}

# simulate data
set.seed(42)
sim_data = gen_sim_data(sample_size = 500)

# goal is to "tune" knn

# train-test split data
trn_idx = sample(nrow(sim_data), size = 0.8 * nrow(sim_data))
trn = sim_data[trn_idx, ]
tst = sim_data[-trn_idx, ]

# estimation-validation split data
est_idx = sample(nrow(trn), size = 0.8 * nrow(trn))
est = trn[est_idx, ]
val = trn[-est_idx, ]

# fit model
mod = caret::knnreg(y ~ x, data = est, k = 10)

# making predictions
pred = predict(mod, val)

# calculating a metric (RMSE)
sqrt(mean((pred - val$y) ^ 2))

# values of k to try
k_vals = 1:100

# function to validate model
validate_knn_model = function(k) {
  mod = caret::knnreg(y ~ x, data = est, k = k)
  pred = predict(mod, val)
  sqrt(mean((pred - val$y) ^ 2))
}

val_results = sapply(k_vals, validate_knn_model)
plot(val_results, type = "l")
grid()

which.min(val_results)

################################################################################

idx_folds = caret::createFolds(trn$y, k = 5)


calc_rmse_knn_single_fold = function(val_idx, k) {

  # split within fold
  est = trn[-val_idx, ]
  val = trn[val_idx, ]

  # fit model
  mod = caret::knnreg(y ~ x, data = est, k = k)

  # making predictions
  pred = predict(mod, val)

  # calculating a metric (RMSE)
  sqrt(mean((pred - val$y) ^ 2))
}

calc_rmse_knn_single_fold(idx_folds$Fold1, k = 10)
calc_rmse_knn_single_fold(idx_folds$Fold2, k = 10)
calc_rmse_knn_single_fold(idx_folds$Fold3, k = 10)
calc_rmse_knn_single_fold(idx_folds$Fold4, k = 10)
calc_rmse_knn_single_fold(idx_folds$Fold5, k = 10)


mean(sapply(idx_folds, calc_rmse_knn_single_fold, k = 1))
mean(sapply(idx_folds, calc_rmse_knn_single_fold, k = 2))
mean(sapply(idx_folds, calc_rmse_knn_single_fold, k = 3))


calc_cv_rmse_for_k = function(k) {
  fold_rmse = sapply(idx_folds, calc_rmse_knn_single_fold, k = k)
  c(
    cv_rmse = mean(fold_rmse),
    sd_cv_rmse = sd(fold_rmse)
  )
}

idx_folds = caret::createFolds(trn$y, k = 5)
cv_rmse_results = sapply(k_vals, calc_cv_rmse_for_k)
best_mod_k = which.min(cv_rmse_results[1, ])



plot(k_vals, cv_rmse_results[1, ], type = "l", ylim = c(0.2, 0.4))
grid()
lines(k_vals, cv_rmse_results[1, ] - cv_rmse_results[2, ], type = "l", col = "dodgerblue")
lines(k_vals, cv_rmse_results[1, ] + cv_rmse_results[2, ], type = "l", col = "dodgerblue")
abline(v = 30, col = "darkgrey")
abline(h = cv_rmse_results[1, best_mod_k] + cv_rmse_results[2, best_mod_k], col = "darkorange")

################################################################################

library(palmerpenguins)

peng = na.omit(penguins)

# train-test split data
peng_trn_idx = sample(nrow(peng), size = 0.8 * nrow(peng))
peng_trn = peng[peng_trn_idx, ]
peng_tst = peng[-peng_trn_idx, ]

peng_cv_idx = caret::createFolds(peng_trn$species, k = 10)


# goal is cross-validated accuracy for tree with minsplit 2 cp 0.001

calc_acc_fold = function(val_idx) {

  # split
  est = peng_trn[-val_idx, ]
  val = peng_trn[val_idx, ]

  # fit model
  mod = rpart::rpart(
    species ~ bill_length_mm + flipper_length_mm,
    data = est,
    cp = 0.001,
    minsplit = 2
  )

  # make predictions
  pred = predict(mod, val, type = "class")

  # calculate metric
  mean(pred == val$species)

}

mean(sapply(peng_cv_idx, calc_acc_fold))



################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################



################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################


<!-- ## R Setup and Source -->

  <!-- ```{r packages, warning = FALSE, message = FALSE} -->
  <!-- library(tibble) # data frame printing -->
<!-- library(dplyr)  # data manipulation -->

<!-- library(caret)  # fitting knn, additional functions and data -->
<!-- library(rpart)  # fitting trees -->
<!-- ``` -->

  <!-- Recall that the [Welcome](index.html) chapter contains directions for installing all necessary packages for following along with the text. The R Markdown source is provided as some code, mostly for creating plots, has been suppressed from the rendered document that you are currently reading. -->

  <!-- - **R Markdown Source:** [`cross-validation.Rmd`](cross-validation.Rmd) -->








  <!-- ## Sacramento Data -->

  <!-- ```{r} -->
  <!-- data("Sacramento", package = "caret") -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- # set seed -->
  <!-- set.seed(42) -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- # train-test split data -->
  <!-- trn_idx = sample(nrow(Sacramento), size = 0.8 * nrow(Sacramento)) -->
  <!-- trn = Sacramento[trn_idx, ] -->
  <!-- tst = Sacramento[-trn_idx, ] -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- # estimation validation split data -->
  <!-- est_idx = sample(nrow(trn), size = 0.8 * nrow(trn)) -->
  <!-- est = trn[est_idx, ] -->
  <!-- val = trn[-est_idx, ] -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- # fit model -->
  <!-- mod = knnreg(price ~ beds + baths + sqft + type, data = est) -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- # make predictions -->
  <!-- preds = predict(mod, val) -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- # calculate metric -->
  <!-- mean(abs(preds - val$price)) -->
  <!-- ``` -->


  <!-- ```{r} -->
  <!-- # repeat process? -->
  <!-- split_and_calc_metric = function(k) { -->

      <!--   est_idx = sample(nrow(trn), size = 0.8 * nrow(trn)) -->
        <!--   est = trn[est_idx, ] -->
          <!--   val = trn[-est_idx, ] -->

            <!--   mod = knnreg(price ~ beds + baths + sqft + type, data = est, k = k) -->

              <!--   preds = predict(mod, val) -->

                <!--   mean(abs(preds - val$price)) -->
                <!-- } -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- aaaa = sapply(1:200, split_and_calc_metric) -->
  <!-- ``` -->


  <!-- ```{r} -->
  <!-- folds = createFolds(trn$price, k = 5) -->
  <!-- ``` -->


  <!-- ```{r} -->
  <!-- calc_metric_single_fold = function(val_idx, k) { -->

      <!--   # create estimation-validation split -->
      <!--   est = trn[-val_idx, ] -->
        <!--   val = trn[val_idx, ] -->

          <!--   # fit model -->
          <!--   mod = knnreg(price ~ beds + baths + sqft + type, data = est, k = k) -->

            <!--   # make predictions -->
            <!--   preds = predict(mod, val) -->

              <!--   # calculate metric -->
              <!--   mean(abs(preds - val$price)) -->

              <!-- } -->

  <!-- ``` -->


  <!-- ```{r} -->
  <!-- mean(sapply(folds, calc_metric_single_fold, k = 250)) -->
  <!-- ``` -->


  <!-- ```{r} -->
  <!-- calc_cv_metric = function(k) { -->
      <!--   fold_results = sapply(folds, calc_metric_single_fold, k = k) -->
        <!--   c(cv_metric = mean(fold_results), sd_metric = sd(fold_results)) -->
        <!-- } -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- asdf = sapply(1:200, calc_cv_metric) -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- bbbb = as.data.frame(t(asdf)) -->
  <!-- ``` -->


  <!-- ```{r} -->
  <!-- par(mfrow = c(1, 2)) -->
  <!-- plot(aaaa, type = "l") -->
  <!-- grid() -->
  <!-- plot(bbbb$cv_metric, type = "l", ylim = c(50000, 80000)) -->
  <!-- grid() -->
  <!-- lines(1:200, bbbb$cv_metric - bbbb$sd_metric, col = "dodgerblue") -->
  <!-- lines(1:200, bbbb$cv_metric + bbbb$sd_metric, col = "dodgerblue") -->
  <!-- abline(h = bbbb$cv_metric[69] + bbbb$sd_metric[69], col = "darkorange") -->
  <!-- ``` -->


  <!-- - two more examples -->
  <!--   - classification with acc/mis -->
  <!--   - classification with "silly" metric -->


  <!-- *** -->

  <!-- In this chapter... -->

  <!-- *** -->

  <!-- ## Reading -->

  <!-- - **Required:** ??? -->

  <!-- *** -->



  <!-- *** -->

  <!-- TBD -->

  <!-- *** -->

  <!-- ## Source -->

  <!-- - `R` Markdown: [`cross-validation.Rmd`](cross-validation.Rmd) -->

  <!-- *** -->

  <!-- *** -->

  <!-- *** -->

  <!-- ## STAT 432 Materials -->

  <!-- - [**Code** | Some Resampling Code](https://fall-2019.stat432.org/misc/some-resampling-code-for-class.R) -->

  <!-- *** -->

  <!-- ```{r resampling_opts, include = FALSE} -->
  <!-- knitr::opts_chunk$set(cache = TRUE, autodep = TRUE, fig.align = "center") -->
  <!-- ``` -->

  <!-- ```{r, message = FALSE, warning = FALSE} -->
  <!-- library("dplyr") -->
  <!-- library("rsample") -->
  <!-- library("tibble") -->
  <!-- library("knitr") -->
  <!-- library("kableExtra") -->
  <!-- library("purrr") -->
  <!-- ``` -->

  <!-- In this chapter we introduce **cross-validation**. We will highlight the need for cross-validation by comparing it to our previous approach, which was to use a single **validation** set inside of the training data. -->

  <!-- To illustrate the use of cross-validation, we'll consider a regression setup with a single feature $x$, and a regression function $f(x) = x^3$. Adding an additional noise parameter, and the distribution of the feature variable, we define the entire data generating process as -->

<!-- $$ -->
<!-- X \sim \text{Unif}\left(a = -1, b = 1\right) \\ -->
<!-- Y \mid X \sim \text{Normal}\left(\mu = x^3, \sigma^2 = 0.25 ^ 2\right) -->
<!-- $$ -->

<!-- We write an `R` function that generates datasets according to this process. -->

<!-- ```{r} -->
<!-- gen_sim_data = function(sample_size) { -->
<!--   x = runif(n = sample_size, min = -1, max = 1) -->
<!--   y = rnorm(n = sample_size, mean = x ^ 3, sd = 0.25) -->
<!--   tibble(x, y) -->
<!-- } -->
<!-- ``` -->

<!-- We first simulate a single train dataset, which we also split into an *estimation* and *validation* set. We also simulate a large test dataset. (Which we could not do in pratice, but is possible here.) -->

<!-- ```{r} -->
<!-- set.seed(1) -->
<!-- sim_trn = gen_sim_data(sample_size = 200) -->
<!-- sim_idx = sample(1:nrow(sim_trn), 160) -->
<!-- sim_est = sim_trn[sim_idx, ] -->
<!-- sim_val = sim_trn[-sim_idx, ] -->
<!-- sim_tst = gen_sim_data(sample_size = 10000) -->
<!-- ``` -->

<!-- We plot this training data, as well as the true regression function. -->

<!-- ```{r} -->
<!-- plot(y ~ x, data = sim_trn, col = "dodgerblue", pch = 20) -->
<!-- grid() -->
<!-- curve(x ^ 3, add = TRUE, col = "black", lwd = 2) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- calc_rmse = function(actual, predicted) { -->
<!--   sqrt(mean((actual - predicted) ^ 2)) -->
<!-- } -->
<!-- ``` -->

<!-- Recall that we needed this validation set because the training error was far too optimistic for highly flexible models. This would lead us to always use the most flexible model. (That is, data that is used to fit a model should not be used to validate a model.) -->

<!-- ```{r} -->
<!-- tibble( -->
<!--   "Polynomial Degree" = 1:10, -->
<!--   "Train RMSE" = map_dbl(1:10, ~ calc_rmse(actual = sim_est$y, predicted = predict(lm(y ~ poly(x, .x), data = sim_est), sim_est))), -->
<!--   "Validation RMSE" = map_dbl(1:10, ~ calc_rmse(actual = sim_val$y, predicted = predict(lm(y ~ poly(x, .x), data = sim_est), sim_val))) -->
<!-- ) %>% -->
<!--   kable(digits = 4) %>% -->
<!--   kable_styling("striped", full_width = FALSE) -->
<!-- ``` -->

<!-- ## Validation-Set Approach -->

<!-- - TODO: consider fitting polynomial models of degree k = 1:10 to data from this data generating process -->
<!-- - TODO: here, we can consider k, the polynomial degree, as a tuning parameter -->
<!-- - TODO: perform simulation study to evaluate how well validation set approach works -->

<!-- ```{r} -->
<!-- num_sims = 100 -->
<!-- num_degrees = 10 -->
<!-- val_rmse = matrix(0, ncol = num_degrees, nrow = num_sims) -->
<!-- ``` -->

<!-- - TODO: each simulation we will... -->

<!-- ```{r} -->
<!-- set.seed(42) -->
<!-- for (i in 1:num_sims) { -->

<!--   # simulate data -->
<!--   sim_trn = gen_sim_data(sample_size = 200) -->

<!--   # set aside validation set -->
<!--   sim_idx = sample(1:nrow(sim_trn), 160) -->
<!--   sim_est = sim_trn[sim_idx, ] -->
<!--   sim_val = sim_trn[-sim_idx, ] -->

<!--   # fit models and store RMSEs -->
<!--   for (j in 1:num_degrees) { -->

<!--     #fit model -->
<!--     fit = glm(y ~ poly(x, degree = j), data = sim_est) -->

<!--     # calculate error -->
<!--     val_rmse[i, j] = calc_rmse(actual = sim_val$y, predicted = predict(fit, sim_val)) -->
<!--   } -->
<!-- } -->
<!-- ``` -->

<!-- ```{r echo = FALSE, fig.height = 5, fig.width = 10} -->
<!-- par(mfrow = c(1, 2)) -->
<!-- matplot(t(val_rmse)[, 1:20], pch = 20, type = "b", ylim = c(0.17, 0.35), xlab = "Polynomial Degree", ylab = "RMSE", main = "RMSE vs Degree") -->
<!-- barcol = c("grey", "grey", "dodgerblue", "grey", "grey", "grey", "grey", "grey", "grey", "grey") -->
<!-- grid() -->
<!-- barplot(table(factor(apply(val_rmse, 1, which.min), levels = 1:10)), -->
<!--         ylab = "Times Chosen", xlab = "Polynomial Degree", col = barcol, main = "Model Chosen vs Degree", -->
<!--         ylim = c(0, 35)) -->
<!-- box() -->
<!-- grid() -->
<!-- ``` -->

<!-- - TODO: issues are hard to "see" but have to do with variability -->
<!-- - TODO: sometimes we are selecting models that are not flexible enough! -->

<!-- ## Cross-Validation -->

<!-- Instead of using a single estimation-validation split, we instead look to use $K$-fold cross-validation. -->

<!-- $$ -->
<!-- \text{RMSE-CV}_{K} = \sum_{k = 1}^{K} \frac{n_k}{n} \text{RMSE}_k -->
<!-- $$ -->

<!-- $$ -->
<!-- \text{RMSE}_k = \sqrt{\frac{1}{n_k} \sum_{i \in C_k} \left( y_i - \hat{f}^{-k}(x_i) \right)^2 } -->
<!-- $$ -->

<!-- - $n_k$ is the number of observations in fold $k$ -->
<!-- - $C_k$ are the observations in fold $k$ -->
<!-- - $\hat{f}^{-k}()$ is the trained model using the training data without fold $k$ -->

<!-- If $n_k$ is the same in each fold, then -->

<!-- $$ -->
<!-- \text{RMSE-CV}_{K} = \frac{1}{K}\sum_{k = 1}^{K} \text{RMSE}_k -->
<!-- $$ -->

<!-- - TODO: create and add graphic that shows the splitting process -->
<!-- - TODO: Can be used with any metric, MSE, RMSE, class-err, class-acc -->

<!-- There are many ways to perform cross-validation in `R`, depending on the statistical learning method of interest. Some methods, for example `glm()` through `boot::cv.glm()` and `knn()` through `knn.cv()` have cross-validation capabilities built-in. We'll use `glm()` for illustration. First we need to convince ourselves that `glm()` can be used to perform the same tasks as `lm()`. -->

  <!-- ```{r} -->
  <!-- glm_fit = glm(y ~ poly(x, 3), data = sim_trn) -->
  <!-- coef(glm_fit) -->
  <!-- lm_fit  = lm(y ~ poly(x, 3), data = sim_trn) -->
  <!-- coef(lm_fit) -->
  <!-- ``` -->

  <!-- By default, `cv.glm()` will report leave-one-out cross-validation (LOOCV). -->

  <!-- ```{r} -->
  <!-- sqrt(boot::cv.glm(sim_trn, glm_fit)$delta) -->
  <!-- ``` -->

  <!-- We are actually given two values. The first is exactly the LOOCV-MSE. The second is a minor correction that we will not worry about. We take a square root to obtain LOOCV-RMSE. -->

  <!-- In practice, we often prefer 5 or 10-fold cross-validation for a number of reason, but often most importantly, for computational efficiency. -->

  <!-- ```{r} -->
  <!-- sqrt(boot::cv.glm(sim_trn, glm_fit, K = 5)$delta) -->
  <!-- ``` -->

  <!-- We repeat the above simulation study, this time performing 5-fold cross-validation. With a total sample size of $n = 200$ each validation set has 40 observations, as did the single validation set in the previous simulations. -->

  <!-- ```{r} -->
  <!-- cv_rmse = matrix(0, ncol = num_degrees, nrow = num_sims) -->
  <!-- ``` -->

  <!-- ```{r} -->
  <!-- set.seed(42) -->
  <!-- for (i in 1:num_sims) { -->

      <!--   # simulate data, use all data for training -->
      <!--   sim_trn = gen_sim_data(sample_size = 200) -->

        <!--   # fit models and store RMSE -->
        <!--   for (j in 1:num_degrees) { -->

            <!--     #fit model -->
            <!--     fit = glm(y ~ poly(x, degree = j), data = sim_trn) -->

              <!--     # calculate error -->
              <!--     cv_rmse[i, j] = sqrt(boot::cv.glm(sim_trn, fit, K = 5)$delta[1]) -->
                <!--   } -->
        <!-- } -->
  <!-- ``` -->

  <!-- ```{r, echo = FALSE, fig.height = 5, fig.width = 10} -->
  <!-- par(mfrow = c(1, 2)) -->
  <!-- max_correct = max(max(table(apply(val_rmse, 1, which.min))), max(table(apply(cv_rmse, 1, which.min)))) + 2 -->
  <!-- barcol = c("grey", "grey", "dodgerblue", "grey", "grey", "grey", "grey", "grey", "grey", "grey") -->
  <!-- barplot(table(factor(apply(val_rmse, 1, which.min), levels = 1:10)), ylim = c(0, max_correct), -->
                 <!--         ylab = "Times Chosen", xlab = "Polynomial Degree", col = barcol, main = "Single Validation Set") -->
  <!-- box() -->
  <!-- grid() -->
  <!-- barplot(table(factor(apply(cv_rmse,  1, which.min), levels = 1:10)), ylim = c(0, max_correct), -->
                 <!--         ylab = "Times Chosen", xlab = "Polynomial Degree", col = barcol, main = "5-Fold Cross-Validation") -->
  <!-- box() -->
  <!-- grid() -->
  <!-- ``` -->

  <!-- ```{r, echo = FALSE} -->
  <!-- results = data.frame( -->
                               <!--   degree = 1:10, -->
                               <!--   colMeans(val_rmse), -->
                               <!--   apply(val_rmse, 2, sd), -->
                               <!--   colMeans(cv_rmse), -->
                               <!--   apply(cv_rmse, 2, sd) -->
                               <!-- ) -->
  <!-- colnames(results) = c( -->
                                <!--   "Polynomial Degree", -->
                                <!--   "Mean, Val", -->
                                <!--   "SD, Val", -->
                                <!--   "Mean, CV", -->
                                <!--   "SD, CV" -->
                                <!-- ) -->

  <!-- kable(results, digits = 3) %>% kable_styling("striped", full_width = FALSE) -->
  <!-- ``` -->

  <!-- ```{r, echo = FALSE, fig.height = 5, fig.width = 10} -->
  <!-- par(mfrow = c(1, 2)) -->
  <!-- matplot(t(val_rmse)[, 1:20], pch = 20, type = "b", ylim = c(0.17, 0.35), xlab = "Polynomial Degree", ylab = "RMSE", main = "Single Validation Set") -->
  <!-- grid() -->
  <!-- matplot(t(cv_rmse)[, 1:20],  pch = 20, type = "b", ylim = c(0.17, 0.35), xlab = "Polynomial Degree", ylab = "RMSE", main = "5-Fold Cross-Validation") -->
  <!-- grid() -->
  <!-- ``` -->

  <!-- - TODO: differences: less variance, better selections -->

  <!-- ## Test Data -->

  <!-- The following example, inspired by The Elements of Statistical Learning, will illustrate the need for a dedicated test set which is **never** used in model training. We do this, if for no other reason, because it gives us a quick sanity check that we have cross-validated correctly. To be specific we will always test-train split the data, then perform cross-validation **within the training data**. -->

  <!-- Essentially, this example will also show how to **not** cross-validate properly. It will also show an example of cross-validation in a classification setting. -->

  <!-- ```{r} -->
  <!-- calc_misclass = function(actual, predicted) { -->
      <!--   mean(actual != predicted) -->
      <!-- } -->
  <!-- ``` -->

  <!-- Consider a binary response $Y$ with equal probability to take values $0$ and $1$. -->

  <!-- $$ -->
  <!-- Y \sim \text{bern}(p = 0.5) -->
  <!-- $$ -->

  <!-- Also consider $p = 10,000$ independent predictor variables, $X_j$, each with a standard normal distribution. -->

  <!-- $$ -->
  <!-- X_j \sim N(\mu = 0, \sigma^2 = 1) -->
  <!-- $$ -->

  <!-- We simulate $n = 100$ observations from this data generating process. Notice that the way we've defined this process, none of the $X_j$ are related to $Y$. -->

<!-- ```{r} -->
<!-- set.seed(42) -->
<!-- n = 200 -->
<!-- p = 10000 -->
<!-- x = replicate(p, rnorm(n)) -->
<!-- y = c(rbinom(n = n, size = 1, prob = 0.5)) -->
<!-- full_data = as_tibble(data.frame(y, x)) -->
<!-- full_data -->
<!-- ``` -->

<!-- Before attempting to perform cross-validation, we test-train split the data, using half of the available data for each. (In practice, with this little data, it would be hard to justify a separate test dataset, but here we do so to illustrate another point.) -->

<!-- ```{r} -->
<!-- trn_idx  = sample(1:nrow(full_data), trunc(nrow(full_data) * 0.5)) -->
<!-- trn_data = full_data[trn_idx,   ] -->
<!-- tst_data = full_data[-trn_idx, ] -->
<!-- ``` -->

<!-- Now we would like to train a logistic regression model to predict $Y$ using the available predictor data. However, here we have $p > n$, which prevents us from fitting logistic regression. To overcome this issue, we will first attempt to find a subset of relevant predictors. To do so, we'll simply find the predictors that are most correlated with the response. -->

  <!-- ```{r} -->
  <!-- # find correlation between y and each predictor variable -->
  <!-- correlations = apply(trn_data[, -1], 2, cor, y = trn_data$y) -->
  <!-- ``` -->

  <!-- ```{r, echo = FALSE} -->
  <!-- hist(correlations, col = "grey", border = "dodgerblue") -->
  <!-- box() -->
  <!-- ``` -->

  <!-- While many of these correlations are small, many very close to zero, some are as large as 0.40. Since our training data has 50 observations, we'll select the 25 predictors with the largest (absolute) correlations. -->

<!-- ```{r} -->
<!-- selected = order(abs(correlations), decreasing = TRUE)[1:25] -->
<!-- correlations[selected] -->
<!-- ``` -->

<!-- We subset the training and test sets to contain only the response as well as these 25 predictors. -->

<!-- ```{r} -->
<!-- trn_screen = trn_data[c(1, selected)] -->
<!-- tst_screen = tst_data[c(1, selected)] -->
<!-- ``` -->

<!-- Then we finally fit an additive logistic regression using this subset of predictors. We perform 10-fold cross-validation to obtain an estimate of the classification error. -->

<!-- ```{r} -->
<!-- add_log_mod = glm(y ~ ., data = trn_screen, family = "binomial") -->
<!-- boot::cv.glm(trn_screen, add_log_mod, K = 10)$delta[1] -->
<!-- ``` -->

<!-- The 10-fold cross-validation is suggesting a classification error estimate of almost 30%. -->

<!-- ```{r} -->
<!-- add_log_pred = (predict(add_log_mod, newdata = tst_screen, type = "response") > 0.5) * 1 -->
<!-- calc_misclass(predicted = add_log_pred, actual = tst_screen$y) -->
<!-- ``` -->

<!-- However, if we obtain an estimate of the error using the set, we see an error rate of about 50%. No better than guessing! But since $Y$ has no relationship with the predictors, this is actually what we would expect. This incorrect method we'll call screen-then-validate. -->

  <!-- Now, we will correctly screen-while-validating. Essentially, instead of simply cross-validating the logistic regression, we also need to cross validate the screening process. That is, we won't simply use the same variables for each fold, we get the "best" predictors for each fold. -->

<!-- For methods that do not have a built-in ability to perform cross-validation, or for methods that have limited cross-validation capability, we will need to write our own code for cross-validation. (Spoiler: This is not completely true, but let's pretend it is, so we can see how to perform cross-validation from scratch.) -->

  <!-- This essentially amounts to randomly splitting the data, then looping over the splits. The `createFolds()` function from the `caret()` package will make this much easier. -->

  <!-- ```{r} -->
  <!-- caret::createFolds(trn_data$y, k = 10) -->
  <!-- ``` -->


  <!-- ```{r} -->
  <!-- # use the caret package to obtain 10 "folds" -->
  <!-- folds = caret::createFolds(trn_data$y, k = 10) -->

    <!-- # for each fold -->
    <!-- # - pre-screen variables on the 9 training folds -->
    <!-- # - fit model to these variables -->
    <!-- # - get error on validation fold -->
    <!-- fold_err = rep(0, length(folds)) -->

      <!-- for (i in seq_along(folds)) { -->

          <!--   # split for fold i -->
          <!--   est_fold = trn_data[-folds[[i]], ] -->
            <!--   val_fold = trn_data[folds[[i]], ] -->

              <!--   # screening for fold i -->
              <!--   correlations = apply(est_fold[, -1], 2, cor, y = est_fold[,1]) -->
                <!--   selected = order(abs(correlations), decreasing = TRUE)[1:25] -->
                  <!--   est_fold_screen = est_fold[ , c(1, selected)] -->
                    <!--   val_fold_screen = val_fold[ , c(1, selected)] -->

                      <!--   # error for fold i -->
                      <!--   add_log_mod = glm(y ~ ., data = est_fold_screen, family = "binomial") -->
                        <!--   add_log_prob = predict(add_log_mod, newdata = val_fold_screen, type = "response") -->
                          <!--   add_log_pred = ifelse(add_log_prob > 0.5, yes = 1, no = 0) -->
                            <!--   fold_err[i] = mean(add_log_pred != val_fold_screen$y) -->

                              <!-- } -->

      <!-- # report all 10 validation fold errors -->
      <!-- fold_err -->

      <!-- # properly cross-validated error -->
      <!-- # this roughly matches what we expect in the test set -->
      <!-- mean(fold_err) -->
      <!-- ``` -->

      <!-- - TODO: note that, even cross-validated correctly, this isn't a brilliant variable selection procedure. (it completely ignores interactions and correlations among the predictors. however, if it works, it works.) next chapters... -->

<!-- - TODO: calculate test error -->





<!-- ## MISC TODOS -->

<!-- - TODO: https://github.com/topepo/caret/issues/70 -->
<!-- - TODO: https://stats.stackexchange.com/questions/266225/step-by-step-explanation-of-k-fold-cross-validation-with-grid-search-to-optimise -->
<!-- - TODO: https://weina.me/nested-cross-validation/ -->
<!-- - rsample::nested_cv -->
<!-- - http://appliedpredictivemodeling.com/blog/2014/11/27/08ks7leh0zof45zpf5vqe56d1sahb0 -->
<!-- - http://appliedpredictivemodeling.com/blog/2014/11/27/vpuig01pqbklmi72b8lcl3ij5hj2qm -->
<!-- - http://appliedpredictivemodeling.com/blog/2017/9/2/njdc83d01pzysvvlgik02t5qnaljnd -->



################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################

