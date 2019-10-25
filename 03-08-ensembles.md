# Ensembles

***

## STAT 432 Materials

- [**Slides** | Ensemble Methods](https://fall-2019.stat432.org/slides/ensembles.pdf)

***




```r
library("tibble")
library("rpart")
library("rpart.plot")
library("caret")
library("purrr")
```

## Bagging


```r
sin_dgp = function(sample_size = 150) {
  x = runif(n = sample_size, min = -10, max = 10)
  y = 2 * sin(x) + rnorm(n = sample_size)
  tibble(x = x, y = y)
}
```


```r
set.seed(42)
```


```r
par(mfrow = c(1, 3))

some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
fit_1 = rpart(y ~ x, data = some_data, cp = 0)
curve(predict(fit_1, tibble(x = x)), add = TRUE, lwd = 2)
      
some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
fit_2 = rpart(y ~ x, data = some_data, cp = 0)
curve(predict(fit_2, tibble(x = x)), add = TRUE, lwd = 2)

some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
fit_3 = rpart(y ~ x, data = some_data, cp = 0)
curve(predict(fit_3, tibble(x = x)), add = TRUE, lwd = 2)
```



\begin{center}\includegraphics{03-08-ensembles_files/figure-latex/unnamed-chunk-4-1} \end{center}


```r
par(mfrow = c(1, 3))

rpart.plot(fit_1)
rpart.plot(fit_2)
rpart.plot(fit_3)
```



\begin{center}\includegraphics{03-08-ensembles_files/figure-latex/unnamed-chunk-5-1} \end{center}


```r
bag_pred = function(x) {
  apply(t(map_df(boot_reps, predict, data.frame(x = x))), 2, mean)
}

set.seed(42)
boot_idx = caret::createResample(y = some_data$y, times = 100)
boot_reps = map(boot_idx, ~ rpart(y ~ x, data = some_data[.x, ], cp = 0))
bag_pred(x = c(-1, 0 , 1))
```

```
## [1] -1.87295394  0.06556445  1.18010317
```


```r
par(mfrow = c(1, 3))

some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
boot_idx = caret::createResample(y = some_data$y, times = 100)
boot_reps = map(boot_idx, ~ rpart(y ~ x, data = some_data[.x, ], cp = 0))
curve(bag_pred(x = x), add = TRUE, lwd = 2)

some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
boot_idx = caret::createResample(y = some_data$y, times = 100)
boot_reps = map(boot_idx, ~ rpart(y ~ x, data = some_data[.x, ], cp = 0))
curve(bag_pred(x = x), add = TRUE, lwd = 2)

some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
boot_idx = caret::createResample(y = some_data$y, times = 100)
boot_reps = map(boot_idx, ~ rpart(y ~ x, data = some_data[.x, ], cp = 0))
curve(bag_pred(x = x), add = TRUE, lwd = 2)
```



\begin{center}\includegraphics{03-08-ensembles_files/figure-latex/unnamed-chunk-7-1} \end{center}

### Simultation Study


```r
new_obs = tibble(x = 0, y = (2 * sin(0)))
```


```r
sim_bagging_vs_single = function() {
  some_data = sin_dgp()
  
  single = predict(rpart(y ~ x, data = some_data, cp = 0), new_obs)
  
  boot_idx = caret::createResample(y = some_data$y, times = 100)
  boot_reps = map(boot_idx, ~ rpart(y ~ x, data = some_data[.x, ], cp = 0))
  bagged = mean(map_dbl(boot_reps, predict, new_obs))
  c(single = single, bagged = bagged)
}

set.seed(42)
sim_results = replicate(n = 250, sim_bagging_vs_single())
apply(sim_results, 1, mean)
```

```
##    single.1      bagged 
## -0.02487810  0.03302126
```

```r
apply(sim_results, 1, var)
```

```
##  single.1    bagged 
## 1.0147130 0.3356579
```
