# Binary Classification

Full book chapter still delayed! Keeping up with writing every week is getting tough. Below are the notes from the video.

- [**Notes:** Binary Classification](files/binary-classification.pdf)


```r
# binary classification ########################################################

# install package if necessary
# install.packages("devtools")
# devtools::install_github("coatless/ucidata")

# load packages
library(ucidata)
library(tibble)
library(rpart)
library(rpart.plot)
library(caret)
library(cvms)

# load data
bc = na.omit(tibble::as_tibble(bcw_original))

# data prep
bc = bc %>%
  dplyr::mutate(class = factor(class, labels = c("benign", "malignant"))) %>%
  dplyr::select(-sample_code_number)

# test-train split
bc_trn_idx = sample(nrow(bc), size = 0.8 * nrow(bc))
bc_trn = bc[bc_trn_idx, ]
bc_tst = bc[-bc_trn_idx, ]

# estimation-validation split
bc_est_idx = sample(nrow(bc_trn), size = 0.8 * nrow(bc_trn))
bc_est = bc_trn[bc_est_idx, ]
bc_val = bc_trn[-bc_est_idx, ]

# check data
head(bc_trn)
levels(bc_trn$class)

# fit models
mod_knn  = knn3(class ~ clump_thickness + mitoses, bc_est)
mod_tree = rpart(class ~ clump_thickness + mitoses, bc_est)
mod_glm  = glm(class ~ clump_thickness + mitoses, bc_est, family = "binomial")

# get predicted probabilities for "positive" class
set.seed(42)
prob_knn  = predict(mod_knn, bc_val)[, "malignant"]
prob_tree = predict(mod_tree, bc_val)[, "malignant"]
prob_glm  = predict(mod_glm, bc_val, type = "response")

# create tibble of results for knn
results = tibble(
  actual   = bc_val$class,
  prob_knn  = prob_knn,
  prob_tree = prob_tree,
  prob_glm  = prob_glm
)

# evaluate knn with various metrics
knn_eval = evaluate(
  data = results,
  target_col = "actual",
  prediction_cols = "prob_knn",
  positive = "malignant",
  type = "binomial",
  metrics = list("Accuracy" = TRUE),
  cutoff = 0.5)

# view results of evaluation
knn_eval

# plot confusion matrix
plot_confusion_matrix(knn_eval$`Confusion Matrix`[[1]])

# manually create confusion matrix
conf_mat = table(
  predicted = predict(mod_knn, bc_val, type = "class"),
  actual = bc_val$class
)

# plot confusion matrix
plot_confusion_matrix(
  conf_matrix = as_tibble(conf_mat),
  targets_col = "actual",
  predictions_col = "predicted",
  counts_col = "n"
)

# calculate sensitivity "by hand" for logistic regression
pred_glm = factor(ifelse(prob_glm > 0.5, "malignant", "benign"))
sum(pred_glm == "malignant" & bc_val$class == "malignant") / sum(bc_val$class == "malignant")

# check with "automatic" procedure

# create tibble of results for glm
glm_results = tibble(
  actual   = bc_val$class,
  prob_pos = prob_glm
)

# evaluate glm with various metrics
glm_eval = evaluate(
  data = results,
  target_col = "actual",
  prediction_cols = "prob_glm",
  positive = "malignant",
  type = "binomial",
  metrics = list("Accuracy" = TRUE),
  cutoff = 0.5)

# view results of evaluation
glm_eval
glm_eval$Sensitivity

# multi-class classification ###################################################

# load additional packages
library(palmerpenguins)

# remove missing data
peng = na.omit(penguins)

# test-train split
peng_trn_idx = sample(nrow(peng), size = 0.8 * nrow(peng))
peng_trn = peng[peng_trn_idx, ]
peng_tst = peng[-peng_trn_idx, ]

# check data
peng_trn

# fit model
mod_tree = rpart(species ~ . - year, data = peng_trn)

# manually create confusion matrix
conf_mat = table(
  predicted = predict(mod_tree, peng_tst, type = "class"),
  actual = peng_tst$species
)

# plot confusion matrix
plot_confusion_matrix(
  conf_matrix = as_tibble(conf_mat),
  targets_col = "actual",
  predictions_col = "predicted",
  counts_col = "n"
)

# summarize results on test data
peng_results = tibble(
  actual    = peng_tst$species,
  Adelie    = predict(mod_tree, peng_tst)[, "Adelie"],
  Chinstrap = predict(mod_tree, peng_tst)[, "Chinstrap"],
  Gentoo    = predict(mod_tree, peng_tst)[, "Gentoo"]
)

# evaluate metrics on test data
peng_eval = evaluate(
  data = peng_results,
  target_col = "actual",
  prediction_cols = c("Adelie", "Chinstrap", "Gentoo"),
  type = "multinomial",
  metrics = list("Accuracy" = TRUE)
)

# view evaluation
peng_eval$`Class Level Results`
peng_eval$Predictions
plot_confusion_matrix(peng_eval$`Confusion Matrix`[[1]])
```


<!-- ```{r setup, include = FALSE} -->
<!-- knitr::opts_chunk$set(echo = TRUE, fig.align = "center", cache = TRUE, autodep = TRUE) -->
<!-- ``` -->

<!-- *** -->

<!-- In this chapter... -->

<!-- *** -->

<!-- ## Reading -->

<!-- - **Required:** [Wikipedia: Confusion Matrix](https://en.wikipedia.org/wiki/Confusion_matrix) -->
<!-- - **Required:** [Wikipedia: Sensitivity and Specificity](https://en.wikipedia.org/wiki/Sensitivity_and_specificity) -->
<!-- - **Required:** [Wikipedia: Precision and Recall](https://en.wikipedia.org/wiki/Precision_and_recall) -->
<!-- - **Required:** [Wikipedia: Evaluation of Binary Classifiers](https://en.wikipedia.org/wiki/Evaluation_of_binary_classifiers) -->

<!-- *** -->

<!-- ```{r packages, message = FALSE, warning = FALSE} -->
<!-- library("tidyverse") -->
<!-- ``` -->

<!-- *** -->

<!-- TBD -->

<!-- *** -->

<!-- ## Source -->

<!-- - `R` Markdown: [`binary-classification.Rmd`](binary-classification.Rmd) -->

<!-- *** -->
