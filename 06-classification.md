# Classification

## STAT 432 Materials

- [**Slides** | Classification: Introduction](https://fall-2019.stat432.org/slides/classification.pdf)
- [**Code** | Some Classification Code](https://fall-2019.stat432.org/misc/some-class-code-for-class.R)
- [**Slides** | Classification: Binary Classification](https://fall-2019.stat432.org/slides/binary-classification.pdf)
- [**Code** | Some Binary Classification Code](https://fall-2019.stat432.org/misc/some-binary-class-code-for-class.R)
- [**Slides** | Classification: Nonparametric Classification](https://fall-2019.stat432.org/slides/nonparametric-classification.pdf)
- [**Reading** | STAT 420: Logistic Regression](https://daviddalpiaz.github.io/appliedstats/logistic-regression.html)
- [**Slides** | Classification: Logistic Regression](https://fall-2019.stat432.org/slides/logistic-regression.pdf)

***

## Bayes Classifier

- TODO: Not the same as naïve Bayes classifier

$$
C^B(x) = \underset{k \in \{1, 2, \ldots K\}}{\text{argmax}} P\left[ Y = k \mid X = x \right]
$$

***

### Bayes Error Rate

$$
1 - \mathbb{E}\left[ \underset{k}{\text{max}} \ P[Y = k \mid X] \right]
$$

- TODO: https://topepo.github.io/caret/visualizations.html
- TODO: https://en.wikipedia.org/wiki/Confusion_matrix
- TODO: https://en.wikipedia.org/wiki/Matthews_correlation_coefficient
- TODO: https://people.inf.elte.hu/kiss/11dwhdm/roc.pdf
- TODO: https://www.cs.cmu.edu/~tom/mlbook/NBayesLogReg.pdf
- TODO: http://www.oranlooney.com/post/viz-tsne/
- TODO: https://web.expasy.org/pROC/
- TODO: https://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/1471-2105-12-77
- TODO: https://en.wikipedia.org/wiki/Receiver_operating_characteristic
- TODO: https://papers.nips.cc/paper/2020-on-discriminative-vs-generative-classifiers-a-comparison-of-logistic-regression-and-naive-bayes.pdf


```r
library(tibble)
library(caret)
```

```
## Loading required package: lattice
```

```
## Loading required package: ggplot2
```

```r
library(rpart)
library(nnet)
```


```r
gen_data = function(n = 100) {
  x = sample(c(0, 1), prob = c(0.4, 0.6), size = n, replace = TRUE)
  y = ifelse(test = {x == 0},
             yes = sample(c("A", "B", "C"), size = n, prob = c(0.25, 0.50, 0.25), replace = TRUE),
             no = sample(c("A", "B", "C"), size = n, prob = c(0.1, 0.1, 0.4) / 0.6, replace = TRUE))

  tibble(x = x, y = factor(y))
}

test_cases = tibble(x = c(0, 1))

set.seed(42)
some_data = gen_data()

predict(knn3(y ~ x, data = some_data), test_cases)
```

```
##              A          B         C
## [1,] 0.2608696 0.39130435 0.3478261
## [2,] 0.1481481 0.07407407 0.7777778
```

```r
predict(rpart(y ~ x, data = some_data), test_cases)
```

```
##           A          B         C
## 1 0.2608696 0.39130435 0.3478261
## 2 0.1481481 0.07407407 0.7777778
```

```r
predict(nnet(y ~ x, data = some_data, size = 0, skip = TRUE, trace = FALSE), test_cases)
```

```
##           A          B         C
## 1 0.2608693 0.39130387 0.3478268
## 2 0.1481479 0.07407422 0.7777779
```

## Modeling

### Linear Models


```r
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
```

![](06-classification_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 

### k-Nearest Neighbors

### Decision Trees
