# Classification



Full book chapter still delayed! Keeping up with writing every week is getting tough. Below are the notes from the video.

- [**Notes:** Classification](files/classification.pdf)

<!-- TODO: add confusion matrix, and plot? -->

<!-- This chapter continues our discussion of **supervised learning** by introducing the **classification** tasks. Like regression, we will focus on the conditional distribution of the response. -->

<!-- Specifically, we will discuss: -->

<!-- - The setup for the **classification** task.  -->
<!-- - The **Bayes classifier** and **Bayes error**. -->
<!-- - Estimating **conditional probabilities**. -->
<!-- - Two simple **metrics** for the classification task. -->

<!-- ## R Setup and Source -->

<!-- ```{r packages, warning = FALSE, message = FALSE} -->
<!-- library(tibble)     # data frame printing -->
<!-- library(dplyr)      # data manipulation -->

<!-- library(knitr)      # creating tables -->
<!-- library(kableExtra) # styling tables -->
<!-- ``` -->

<!-- Additionally, objects from `ggplot2`, `GGally`, and `ISLR` are accessed. Recall that the [Welcome](index.html) chapter contains directions for installing all necessary packages for following along with the text. The R Markdown source is provided as some code, mostly for creating plots, has been suppressed from the rendered document that you are currently reading. -->

<!-- - **R Markdown Source:** [`classification.Rmd`](classification.Rmd) -->

<!-- ## Data Setup -->

<!-- ## Mathematical Setup -->

<!-- ## Example -->

<!-- ```{r, echo = FALSE} -->
<!-- set.seed(1) -->
<!-- joint_probs = round(1:12 / sum(1:12), 2) -->
<!-- joint_probs = sample(joint_probs) -->
<!-- joint_dist = matrix(data  = joint_probs, nrow = 3, ncol = 4) -->
<!-- colnames(joint_dist) = c("$X = 1$", "$X = 2$", "$X = 3$", "$X = 4$") -->
<!-- rownames(joint_dist) = c("$Y = A$", "$Y = B$", "$Y = C$") -->
<!-- joint_dist %>% -->
<!--   kable() %>% -->
<!--   kable_styling("striped", full_width = FALSE) %>% -->
<!--   column_spec(column = 1, bold = TRUE, background = "white", border_right = TRUE) -->
<!-- ``` -->

<!-- ```{r, echo = FALSE} -->
<!-- # marginal distribution of Y -->
<!-- t(colSums(joint_dist)) %>% kable() %>% kable_styling(full_width = FALSE) -->
<!-- ``` -->

<!-- ```{r, echo = FALSE} -->
<!-- # marginal distribution of X -->
<!-- t(rowSums(joint_dist)) %>% kable() %>% kable_styling(full_width = FALSE) -->
<!-- ``` -->






<!-- ## Bayes Classifier -->

<!-- - TODO: Not the same as naïve Bayes classifier -->

<!-- $$ -->
<!-- p_k(x) = P\left[ Y = k \mid X = x \right] -->
<!-- $$ -->

<!-- $$ -->
<!-- C^B(x) = \underset{k \in \{1, 2, \ldots K\}}{\text{argmax}} P\left[ Y = k \mid X = x \right] -->
<!-- $$ -->

<!-- *** -->

<!-- ### Bayes Error Rate -->

<!-- $$ -->
<!-- 1 - \mathbb{E}_X\left[ \underset{k}{\text{max}} \ P[Y = k \mid X = x] \right] -->
<!-- $$ -->




<!-- ## Classification Metrics -->

<!-- ### Misclassification -->

<!-- ```{r} -->
<!-- calc_misclass = function(actual, predicted) { -->
<!--   mean(actual != predicted) -->
<!-- } -->
<!-- ``` -->

<!-- ### Accuracy -->

<!-- ```{r} -->
<!-- calc_accuracy = function(actual, predicted) { -->
<!--   mean(actual == predicted) -->
<!-- } -->
<!-- ``` -->

<!-- - TODO: math notation -->
<!-- - TODO: trn, tst, etc -->




















<!-- *** -->

<!-- ## STAT 432 Materials -->

<!-- - [**Slides** | Classification: Introduction](https://fall-2019.stat432.org/slides/classification.pdf) -->
<!-- - [**Code** | Some Classification Code](https://fall-2019.stat432.org/misc/some-class-code-for-class.R) -->
<!-- - [**Slides** | Classification: Binary Classification](https://fall-2019.stat432.org/slides/binary-classification.pdf) -->
<!-- - [**Code** | Some Binary Classification Code](https://fall-2019.stat432.org/misc/some-binary-class-code-for-class.R) -->
<!-- - [**Slides** | Classification: Nonparametric Classification](https://fall-2019.stat432.org/slides/nonparametric-classification.pdf) -->
<!-- - [**Reading** | STAT 420: Logistic Regression](https://daviddalpiaz.github.io/appliedstats/logistic-regression.html) -->
<!-- - [**Slides** | Classification: Logistic Regression](https://fall-2019.stat432.org/slides/logistic-regression.pdf) -->

<!-- *** -->

<!-- ```{r, include = FALSE}  -->
<!-- knitr::opts_chunk$set(cache = TRUE, autodep = TRUE, fig.align = "center") -->
<!-- ``` -->

<!-- ```{r, message = FALSE, warning = FALSE} -->
<!-- library("dplyr") -->
<!-- library("knitr") -->
<!-- library("kableExtra") -->
<!-- library("tibble") -->
<!-- library("caret") -->
<!-- library("rpart") -->
<!-- library("nnet") -->
<!-- ``` -->




<!-- ## Building a Classifier -->

<!-- $$ -->
<!-- \hat{p}_k(x) = \hat{P}\left[ Y = k \mid X = x \right] -->
<!-- $$ -->

<!-- $$ -->
<!-- \hat{C}(x) = \underset{k \in \{1, 2, \ldots K\}}{\text{argmax}} \hat{p}_k(x) -->
<!-- $$ -->

<!-- - TODO: first estimation conditional distribution, then classify to label with highest probability -->




<!-- ```{r} -->
<!-- gen_data = function(n = 100) { -->
<!--   x = sample(c(0, 1), prob = c(0.4, 0.6), size = n, replace = TRUE) -->
<!--   y = ifelse(test = {x == 0}, -->
<!--              yes = sample(c("A", "B", "C"), size = n, prob = c(0.25, 0.50, 0.25), replace = TRUE), -->
<!--              no = sample(c("A", "B", "C"), size = n, prob = c(0.1, 0.1, 0.4) / 0.6, replace = TRUE)) -->

<!--   tibble(x = x, y = factor(y)) -->
<!-- } -->

<!-- test_cases = tibble(x = c(0, 1)) -->

<!-- set.seed(42) -->
<!-- some_data = gen_data() -->

<!-- predict(knn3(y ~ x, data = some_data), test_cases) -->
<!-- predict(rpart(y ~ x, data = some_data), test_cases) -->
<!-- predict(multinom(y ~ x, data = some_data, trace = FALSE), test_cases, type = "prob") -->
<!-- ``` -->

<!-- ## Modeling -->

<!-- ### Linear Models -->

<!-- - TODO: use `nnet::multinom` -->
<!--     - in place of `glm()`? always? -->

<!-- ### k-Nearest Neighbors -->

<!-- - TODO: use `caret::knn3()` -->

<!-- ### Decision Trees -->

<!-- - TODO: use `rpart::rpart()` -->



















