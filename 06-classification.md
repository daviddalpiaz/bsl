# Classification

## Slides

- [Classification: Introduction](https://fall-2019.stat432.org/slides/classification.pdf)

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

### k-Nearest Neighbors

### Decision Trees
