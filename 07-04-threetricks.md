# Three Weird Tricks


```r
library("tidyverse")
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.2.1     v purrr   0.3.3
## v tibble  2.1.3     v dplyr   0.8.3
## v tidyr   1.0.0     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library("quantreg")
```

```
## Loading required package: SparseM
```

```
## 
## Attaching package: 'SparseM'
```

```
## The following object is masked from 'package:base':
## 
##     backsolve
```

```r
library("quantregForest")
```

```
## Loading required package: randomForest
```

```
## randomForest 4.6-14
```

```
## Type rfNews() to see new features/changes/bug fixes.
```

```
## 
## Attaching package: 'randomForest'
```

```
## The following object is masked from 'package:dplyr':
## 
##     combine
```

```
## The following object is masked from 'package:ggplot2':
## 
##     margin
```

```
## Loading required package: RColorBrewer
```

```r
library("mclust")
```

```
## Package 'mclust' version 5.4.5
## Type 'citation("mclust")' for citing this R package in publications.
```

```
## 
## Attaching package: 'mclust'
```

```
## The following object is masked from 'package:purrr':
## 
##     map
```

# Why Estimate Just The Mean?


```r
cars = as_tibble(cars)
```


```r
mod_lm = lm(dist ~ 0 + speed, data = cars)
mod_qr = rq(dist ~ 0 + speed, data = cars, tau = c(0.25, 0.50, 0.75))
```


```r
predict(mod_qr)
```

```
##       [,1] [,2] [,3]
##  [1,]    8 10.4 13.6
##  [2,]    8 10.4 13.6
##  [3,]   14 18.2 23.8
##  [4,]   14 18.2 23.8
##  [5,]   16 20.8 27.2
##  [6,]   18 23.4 30.6
##  [7,]   20 26.0 34.0
##  [8,]   20 26.0 34.0
##  [9,]   20 26.0 34.0
## [10,]   22 28.6 37.4
## [11,]   22 28.6 37.4
## [12,]   24 31.2 40.8
## [13,]   24 31.2 40.8
## [14,]   24 31.2 40.8
## [15,]   24 31.2 40.8
## [16,]   26 33.8 44.2
## [17,]   26 33.8 44.2
## [18,]   26 33.8 44.2
## [19,]   26 33.8 44.2
## [20,]   28 36.4 47.6
## [21,]   28 36.4 47.6
## [22,]   28 36.4 47.6
## [23,]   28 36.4 47.6
## [24,]   30 39.0 51.0
## [25,]   30 39.0 51.0
## [26,]   30 39.0 51.0
## [27,]   32 41.6 54.4
## [28,]   32 41.6 54.4
## [29,]   34 44.2 57.8
## [30,]   34 44.2 57.8
## [31,]   34 44.2 57.8
## [32,]   36 46.8 61.2
## [33,]   36 46.8 61.2
## [34,]   36 46.8 61.2
## [35,]   36 46.8 61.2
## [36,]   38 49.4 64.6
## [37,]   38 49.4 64.6
## [38,]   38 49.4 64.6
## [39,]   40 52.0 68.0
## [40,]   40 52.0 68.0
## [41,]   40 52.0 68.0
## [42,]   40 52.0 68.0
## [43,]   40 52.0 68.0
## [44,]   44 57.2 74.8
## [45,]   46 59.8 78.2
## [46,]   48 62.4 81.6
## [47,]   48 62.4 81.6
## [48,]   48 62.4 81.6
## [49,]   48 62.4 81.6
## [50,]   50 65.0 85.0
```


```r
plot(dist ~ speed, data = cars, pch = 20, col = "darkgrey", xlim = c(0, 30))
grid()
abline(a = 0, b = coef(mod_lm))
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 


```r
plot(dist ~ speed, data = cars, pch = 20, col = "darkgrey", xlim = c(0, 30))
grid()
abline(a = 0, b = coef(mod_qr)[1], col = "limegreen")
abline(a = 0, b = coef(mod_qr)[2], col = "dodgerblue")
abline(a = 0, b = coef(mod_qr)[3], col = "red")
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 


```r
bstn = MASS::Boston
```



```r
gen_weird_data = function(sample_size = 500) {
  x = runif(n = sample_size, min = 1, max = 20)
  y = 2 * sin(x) + rnorm(n = sample_size, sd = log(x))
  tibble(x, y)
}
```


```r
weird_data = gen_weird_data()
plot(y ~ x, data = weird_data, pch = 20, col = "darkgrey", xlim = c(0, 21))
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-9-1.pdf)<!-- --> 


```r
x_seq = matrix(seq(1, 20, by = 0.1))
mod_qrf = quantregForest(x = as.matrix(weird_data$x), y = weird_data$y, nodesize = 50)
p = predict(mod_qrf, x_seq)
```


```r
weird_data = gen_weird_data()
plot(y ~ x, data = weird_data, pch = 20, col = "darkgrey", xlim = c(0, 21))
grid()
lines(x_seq, p[, "quantile= 0.1"], col = "limegreen")
lines(x_seq, p[, "quantile= 0.5"], col = "dodgerblue")
lines(x_seq, p[, "quantile= 0.9"], col = "red")
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-11-1.pdf)<!-- --> 

# Predict "I Don't Know!"


```r
default = as_tibble(ISLR::Default)

mod_glm = glm(default ~ ., data = default, family = "binomial")
pred_probs = predict(mod_glm, default, type = "response")

case_when(
  pred_probs > 0.8 ~ "Yes",
  pred_probs < 0.2 ~ "No",
  TRUE ~ "I DON'T KNOW"
) %>% table()
```

```
## .
## I DON'T KNOW           No          Yes 
##          446         9520           34
```


# Predict That You Shouldn't Predict

- https://stat.washington.edu/mclust/
- https://cran.r-project.org/web/packages/mclust/vignettes/mclust.html


```r
dens = densityMclust(faithful$waiting)
summary(dens, parameters = TRUE)
```

```
## ------------------------------------------------------- 
## Density estimation via Gaussian finite mixture modeling 
## ------------------------------------------------------- 
## 
## Mclust E (univariate, equal variance) model with 2 components: 
## 
##  log-likelihood   n df       BIC       ICL
##       -1034.002 272  4 -2090.427 -2099.576
## 
## Mixing probabilities:
##         1         2 
## 0.3609461 0.6390539 
## 
## Means:
##        1        2 
## 54.61675 80.09239 
## 
## Variances:
##        1        2 
## 34.44093 34.44093
```

```r
plot(dens, what = "BIC", legendArgs = list(x = "topright"))
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-13-1.pdf)<!-- --> 

```r
plot(dens, what = "density", data = faithful$waiting)
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-13-2.pdf)<!-- --> 


```r
dens = densityMclust(faithful, modelNames = "EEE", G = 2)
summary(dens)
```

```
## ------------------------------------------------------- 
## Density estimation via Gaussian finite mixture modeling 
## ------------------------------------------------------- 
## 
## Mclust EEE (ellipsoidal, equal volume, shape and orientation) model with 2
## components: 
## 
##  log-likelihood   n df      BIC      ICL
##       -1140.187 272  8 -2325.22 -2326.71
```

```r
summary(dens, parameters = TRUE)
```

```
## ------------------------------------------------------- 
## Density estimation via Gaussian finite mixture modeling 
## ------------------------------------------------------- 
## 
## Mclust EEE (ellipsoidal, equal volume, shape and orientation) model with 2
## components: 
## 
##  log-likelihood   n df      BIC      ICL
##       -1140.187 272  8 -2325.22 -2326.71
## 
## Mixing probabilities:
##         1         2 
## 0.6407638 0.3592362 
## 
## Means:
##                [,1]      [,2]
## eruptions  4.296012  2.046158
## waiting   80.035996 54.596086
## 
## Variances:
## [,,1]
##           eruptions    waiting
## eruptions 0.1327761  0.7515013
## waiting   0.7515013 35.1702509
## [,,2]
##           eruptions    waiting
## eruptions 0.1327761  0.7515013
## waiting   0.7515013 35.1702509
```

```r
plot(dens, what = "density", data = faithful, 
     drawlabels = FALSE, points.pch = 20)
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-14-1.pdf)<!-- --> 

```r
plot(dens, what = "density", type = "hdr")
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-14-2.pdf)<!-- --> 

```r
plot(dens, what = "density", type = "hdr", prob = c(0.1, 0.9))
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-14-3.pdf)<!-- --> 

```r
plot(dens, what = "density", type = "hdr", data = faithful)
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-14-4.pdf)<!-- --> 

```r
plot(dens, what = "density", type = "persp")
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-14-5.pdf)<!-- --> 


```r
head(predict(dens, what = "dens"))
```

```
##           1           2           3           4           5           6 
## 0.007085957 0.022232181 0.001528346 0.012606154 0.032948304 0.001490981
```

```r
head(predict(dens, what = "z"))
```

```
##              1            2
## 1 9.999913e-01 8.713631e-06
## 2 1.478731e-11 1.000000e+00
## 3 9.966404e-01 3.359577e-03
## 4 4.615524e-07 9.999995e-01
## 5 1.000000e+00 8.828277e-13
## 6 1.675136e-04 9.998325e-01
```


```r
bstn = as_tibble(MASS::Boston)
bstn = bstn %>% mutate(rad = as.factor(rad))
bstn_x = bstn %>% select(-medv)
```


```r
bstn_dens = densityMclust(bstn_x, G = 4)
summary(bstn_dens)
```

```
## ------------------------------------------------------- 
## Density estimation via Gaussian finite mixture modeling 
## ------------------------------------------------------- 
## 
## Mclust VEV (ellipsoidal, equal shape) model with 4 components: 
## 
##  log-likelihood   n  df       BIC       ICL
##       -11377.64 506 383 -25140.04 -25141.56
```


```r
hist(log(predict(bstn_dens, bstn_x)))
grid()
box()
```

![](07-04-threetricks_files/figure-latex/unnamed-chunk-18-1.pdf)<!-- --> 


```r
exp(-300)
```

```
## [1] 5.1482e-131
```












