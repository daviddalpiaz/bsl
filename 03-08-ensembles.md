# Ensembles




```r
library("tibble")
library("rpart")
library("rpart.plot")
library("caret")
library("purrr")
```



```r
sin_dgp = function(sample_size = 200) {
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
fit_1 = rpart(y ~ x, data = some_data)
curve(predict(fit_1, tibble(x = x)), add = TRUE)
      
some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
fit_2 = rpart(y ~ x, data = some_data)
curve(predict(fit_2, tibble(x = x)), add = TRUE)

some_data = sin_dgp()
plot(some_data, pch = 20, col = "darkgrey")
grid()
curve(2 * sin(x), add = TRUE, col = "dodgerblue", lwd = 2)
fit_3 = rpart(y ~ x, data = some_data)
curve(predict(fit_3, tibble(x = x)), add = TRUE)
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
new_obs = tibble(x = 0, y = (2 * sin(0)))
```


```r
sim_bagging_vs_single = function() {
  some_data = sin_dgp()
  
  single = predict(rpart(y ~ x, data = some_data), new_obs)
  
  boot_idx = caret::createResample(y = some_data$y, times = 100)
  boot_reps = map(boot_idx, ~ rpart(y ~ x, data = some_data[.x, ]))
  bagged = mean(map_dbl(boot_reps, predict, new_obs))
  c(single = single, bagged = bagged)
}

sim_results = replicate(n = 250, sim_bagging_vs_single())
apply(sim_results, 1, mean)
```

```
##    single.1      bagged 
## -0.04073238  0.01506561
```

```r
apply(sim_results, 1, var)
```

```
##  single.1    bagged 
## 0.7451381 0.2670599
```
