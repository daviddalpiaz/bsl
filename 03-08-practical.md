# Practical Issues

***

## STAT 432 Materials

- Suggested Reading: [The `caret` Package: Model Training and Tuning](https://topepo.github.io/caret/model-training-and-tuning.html)

***




```r
# load packages
library("tidyverse")
```

```
## -- Attaching packages ---------------------------------- tidyverse 1.2.1 --
```

```
## v ggplot2 3.2.1     v purrr   0.3.3
## v tibble  2.1.3     v dplyr   0.8.3
## v tidyr   1.0.0     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## -- Conflicts ------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library("caret")
```

```
## Loading required package: lattice
```

```
## 
## Attaching package: 'caret'
```

```
## The following object is masked from 'package:purrr':
## 
##     lift
```

```r
library("rpart")
```


```r
# generate date with x1 and x2 on very different scales
gen_reg_data = function(sample_size = 250, beta_1 = 1, beta_2 = 1) {
  x_1 = runif(n = sample_size, min = 0, max = 1)
  x_2 = runif(n = sample_size, min = 0, max = 1000)
  y = beta_1 * x_1 + beta_2 * x_2 + rnorm(n = sample_size)
  tibble(x_1 = x_1, x_2 = x_2, y = y)
}
```


```r
# generate train and test sets
set.seed(42)
trn = gen_reg_data(beta_1 = 10, beta_2 = 0.001)
tst = gen_reg_data(beta_1 = 10, beta_2 = 0.001)
```


```r
trn %>% 
  mutate(x1_scaled = scale(x_1),
         x2_scaled = scale(x_2))
```

```
## # A tibble: 250 x 5
##      x_1   x_2     y x1_scaled[,1] x2_scaled[,1]
##    <dbl> <dbl> <dbl>         <dbl>         <dbl>
##  1 0.915 334.   8.39        1.39          -0.462
##  2 0.937 188.   9.61        1.47          -0.958
##  3 0.286 270.   1.93       -0.765         -0.681
##  4 0.830 531.   9.03        1.10           0.207
##  5 0.642  21.5  7.74        0.455         -1.53 
##  6 0.519 799.   4.96        0.0340         1.12 
##  7 0.737 110.   6.74        0.780         -1.22 
##  8 0.135 540.   1.93       -1.29           0.238
##  9 0.657 571.   6.12        0.507          0.345
## 10 0.705 619.   7.29        0.672          0.507
## # ... with 240 more rows
```


```r
# create scaled datasets
scale_trn = preProcess(trn[, 1:2])
trn_scaled = predict(scale_trn, trn)
tst_scaled = predict(scale_trn, tst)
```


```r
trn_scaled
```

```
## # A tibble: 250 x 3
##        x_1    x_2     y
##      <dbl>  <dbl> <dbl>
##  1  1.39   -0.462  8.39
##  2  1.47   -0.958  9.61
##  3 -0.765  -0.681  1.93
##  4  1.10    0.207  9.03
##  5  0.455  -1.53   7.74
##  6  0.0340  1.12   4.96
##  7  0.780  -1.22   6.74
##  8 -1.29    0.238  1.93
##  9  0.507   0.345  6.12
## 10  0.672   0.507  7.29
## # ... with 240 more rows
```


```r
# linear models -> scaling doesn't matter
# knn -> scaling does matter!
# tress -> scaling doesn't matter
```


```r
lm_u = lm(y ~ ., data = trn)
lm_s = lm(y ~ ., data = trn_scaled)
```


```r
coef(lm_u)
```

```
##   (Intercept)           x_1           x_2 
## -0.0816891578 10.0859803604  0.0009962049
```

```r
coef(lm_s)
```

```
## (Intercept)         x_1         x_2 
##   5.5221016   2.9395824   0.2928511
```


```r
head(cbind(predict(lm_u, tst),
           predict(lm_s, tst_scaled)))
```

```
##        [,1]      [,2]
## 1 9.2073071 9.2073071
## 2 1.3001017 1.3001017
## 3 8.5186045 8.5186045
## 4 5.4156184 5.4156184
## 5 5.6232737 5.6232737
## 6 0.1839076 0.1839076
```


```r
all(predict(lm_u, tst) == predict(lm_s, tst_scaled))
```

```
## [1] FALSE
```

```r
identical(predict(lm_u, tst), predict(lm_s, tst_scaled))
```

```
## [1] FALSE
```

```r
all.equal(predict(lm_u, tst), predict(lm_s, tst_scaled))
```

```
## [1] TRUE
```


```r
knn_u = knnreg(y ~ ., data = trn)
knn_s = knnreg(y ~ ., data = trn_scaled)
```


```r
all.equal(predict(knn_u, tst), predict(knn_s, tst_scaled))
```

```
## [1] "Mean relative difference: 0.4687973"
```


```r
tree_u = rpart(y ~ ., data = trn)
tree_s = rpart(y ~ ., data = trn_scaled)
```


```r
identical(predict(tree_u, tst), predict(tree_s, tst_scaled)) #!
```

```
## [1] TRUE
```

```r
all.equal(predict(tree_u, tst), predict(tree_s, tst_scaled))
```

```
## [1] TRUE
```


```r
set.seed(42)
fit_caret_unscaled = train(
  y ~ .,
  data = trn,
  method = "knn",
  trControl = trainControl(method = "cv", number = 5)
)
fit_caret_unscaled
```

```
## k-Nearest Neighbors 
## 
## 250 samples
##   2 predictor
## 
## No pre-processing
## Resampling: Cross-Validated (5 fold) 
## Summary of sample sizes: 200, 200, 200, 200, 200 
## Resampling results across tuning parameters:
## 
##   k  RMSE      Rsquared     MAE     
##   5  3.470440  0.018004804  2.851823
##   7  3.261563  0.007334744  2.694560
##   9  3.254494  0.016335313  2.685868
## 
## RMSE was used to select the optimal model using the smallest value.
## The final value used for the model was k = 9.
```


```r
set.seed(42)
fit_caret_scaled = train(
  y ~ ., data = trn,
  method = "knn",
  preProcess = c("center", "scale"),
  trControl = trainControl(method = "cv", number = 5))
fit_caret_scaled
```

```
## k-Nearest Neighbors 
## 
## 250 samples
##   2 predictor
## 
## Pre-processing: centered (2), scaled (2) 
## Resampling: Cross-Validated (5 fold) 
## Summary of sample sizes: 200, 200, 200, 200, 200 
## Resampling results across tuning parameters:
## 
##   k  RMSE      Rsquared   MAE      
##   5  1.169505  0.8571820  0.9371406
##   7  1.119903  0.8693966  0.9064097
##   9  1.088236  0.8775694  0.8802256
## 
## RMSE was used to select the optimal model using the smallest value.
## The final value used for the model was k = 9.
```


```r
predict(fit_caret_scaled, tst)
```

```
##   [1]  8.9527676  1.5439899  8.1698569  5.1921137  5.6422941  0.9428402
##   [7]  5.8606918  7.5202928  3.0247919  8.7029136  5.3527194  5.9089646
##  [13]  2.3631140  1.8785465  1.4628721  9.2080534  1.6555496  2.9810578
##  [19]  8.4516162  3.2697351  8.8936368  1.7519259  3.2574896  3.8306247
##  [25]  1.9211518  4.9653897  4.3808786  1.6783049  9.4404156  9.2605951
##  [31]  9.9435929  1.7818664  0.8598750  1.3271484  3.4005296  5.8863736
##  [37]  9.3254538  6.8427627  4.7657257  1.2479047  9.5835391  3.2619959
##  [43]  3.2121993  7.2318322  8.3344221  2.1842123  6.0049012  8.4157259
##  [49]  9.6947759  0.5190365  9.0245357  3.4964364  1.3382749  7.7598367
##  [55]  2.8679602  8.8959226  7.5415946  6.2901721  1.5481898  3.5052455
##  [61]  0.9428402  9.0785051  1.4118006  1.0038657  3.9716100  7.0199951
##  [67]  9.3673932  2.8932812  4.5674353  6.1784035  5.7998128  1.2620623
##  [73]  5.0143113  9.9113321  2.8728658  8.0171859  9.5035696  1.4578539
##  [79]  2.3373766  0.9728382  4.7623395 10.0797202  3.9014748  8.2443235
##  [85]  7.3623528  1.7572069  9.5835391  5.2799754  7.0522089  1.0449684
##  [91]  9.5035696  0.8598750  8.4951896  5.6852855  3.3333067  6.2901721
##  [97]  5.1857211  1.1829847  9.3254538  5.9492812  0.8514072  7.9905756
## [103]  6.2010524  1.0942525  5.4743530  6.5852116  7.8425406  4.3619493
## [109]  8.4414457  9.0319951  6.1784035  3.8466154  9.5835391  8.1018569
## [115]  1.6801906  1.7336386  8.4437695  7.6476428  1.5445405  9.5162125
## [121]  7.4202409  9.3693447  5.2912822  4.1089906  8.3541836  8.3636407
## [127]  5.6709201  7.6476428  1.1284251  4.9584626  0.5372901  8.2291696
## [133]  7.8173373  0.5372901  5.6836612  5.8951205  2.8316394  1.4218593
## [139]  3.6755752  5.4591616  2.4113087  9.9113321  4.0302964  7.0771362
## [145]  2.0595909  2.8728658  0.4906980  2.8667239  4.5119068  1.7336386
## [151]  9.1666873  0.9428402  9.6947759  8.1698569  4.6945450  9.8938321
## [157]  5.1872883  5.6422941  8.4977147  1.4628721  5.2410240  4.8334457
## [163]  3.5536817  4.8060144  0.9465286  3.3784599  1.7613911  3.5672834
## [169]  6.6460721  4.1247747  1.1414461  6.8523315  8.8914922  9.0253203
## [175]  1.1910023  1.9294722  4.4426356  9.7787213  5.8741933  9.9113321
## [181]  5.0292309  2.1620626  6.2351414  3.4903166  7.6644672  8.6339605
## [187]  4.6827277  5.0816345  4.1809836  8.8672306  6.0206635  7.6325977
## [193]  4.1179626  2.1527096  9.0434704  7.3657330  1.0162338  1.6555496
## [199]  9.2267963  4.5648855  4.3583682  5.3837624  8.0171859  1.8097259
## [205]  8.3507965  9.6328376  8.3636407  4.8785945  2.5663612  7.2947992
## [211]  9.8989996  9.6947759  1.0449684  4.1809836  8.7578447  5.8606918
## [217]  3.0910763  3.7622352  0.9816802  9.0239243  1.5439899  7.3280510
## [223]  5.8500676  3.9409908  9.5074820  8.3541836  6.9220954  1.5810614
## [229]  9.3160984  5.9928749  8.0619820  1.9294722  3.5405579  8.4305657
## [235]  8.1581696  5.6852855  6.5852116  5.5793888  6.2010524  2.1527096
## [241]  8.9527676  3.8689628  8.4841111  9.4917012  3.2167342  8.7578447
## [247]  7.0589319  8.5966303  1.9182066  7.8753303
```
