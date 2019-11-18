# Class Imbalance




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
library("DMwR")
```

```
## Loading required package: grid
```

```
## Registered S3 method overwritten by 'xts':
##   method     from
##   as.zoo.xts zoo
```

```
## Registered S3 method overwritten by 'quantmod':
##   method            from
##   as.zoo.data.frame zoo
```

```r
library("ROSE")
```

```
## Loaded ROSE 0.0-3
```

```r
library("randomForest")
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


```r
set.seed(42)
trn = as_tibble(twoClassSim(1000,  intercept = -22))
tst = as_tibble(twoClassSim(10000, intercept = -22))
```


```r
head(trn, n = 10)
```

```
## # A tibble: 10 x 16
##    TwoFactor1 TwoFactor2 Linear01 Linear02 Linear03 Linear04 Linear05 Linear06
##         <dbl>      <dbl>    <dbl>    <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
##  1      0.386     3.14      0.251   -0.686   -0.142   0.0712    0.173   1.42  
##  2     -1.04     -0.415    -0.278   -0.793   -0.814   0.970    -1.27    0.557 
##  3     -0.108     1.04     -1.72    -0.407   -0.326   0.310    -0.868   0.981 
##  4      0.590     1.04     -2.01    -1.15     0.378  -0.140     0.626  -0.586 
##  5      1.11     -0.0699   -1.29     1.12    -1.99   -0.326    -0.106   0.939 
##  6      0.217    -0.490     0.366   -0.879   -0.999  -0.119    -0.256  -0.0647
##  7      1.84      2.04     -0.152    1.28     0.284   0.894    -0.719  -0.254 
##  8      1.61     -1.85     -0.734   -1.45    -1.10    0.211    -2.02   -0.867 
##  9      3.09      2.09     -0.782    0.842    0.983  -0.489     0.390  -2.21  
## 10     -0.553     0.392     0.552   -0.603   -1.02   -0.220    -2.39   -0.915 
## # ... with 8 more variables: Linear07 <dbl>, Linear08 <dbl>, Linear09 <dbl>,
## #   Linear10 <dbl>, Nonlinear1 <dbl>, Nonlinear2 <dbl>, Nonlinear3 <dbl>,
## #   Class <fct>
```


```r
table(trn$Class)
```

```
## 
## Class1 Class2 
##    973     27
```


```r
trn_down = downSample(
  x = trn[, -ncol(trn)],
  y = trn$Class
)

trn_up = upSample(
  x = trn[, -ncol(trn)],
  y = trn$Class
)

trn_rose = ROSE(Class ~ ., data = trn)$data
```


```r
table(trn_down$Class)
```

```
## 
## Class1 Class2 
##     27     27
```

```r
table(trn_up$Class)
```

```
## 
## Class1 Class2 
##    973    973
```

```r
table(trn_rose$Class)
```

```
## 
## Class1 Class2 
##    514    486
```



```r
cv = trainControl(method = "cv", number = 5)
cv_down = trainControl(method = "cv", number = 5, sampling = "down")
cv_up = trainControl(method = "cv", number = 5, sampling = "up")
cv_rose = trainControl(method = "cv", number = 5, sampling = "rose")
```


```r
mod = train(
  Class ~ .,
  data = trn,
  method = "rf",
  trControl = cv
)

mod_down = train(
  Class ~ .,
  data = trn,
  method = "rf",
  trControl = cv_down
)

mod_up = train(
  Class ~ .,
  data = trn,
  method = "rf",
  trControl = cv_up
)

mod_rose = train(
  Class ~ .,
  data = trn,
  method = "rf",
  trControl = cv_rose
)
```


```r
mod_rose
```

```
## Random Forest 
## 
## 1000 samples
##   15 predictor
##    2 classes: 'Class1', 'Class2' 
## 
## No pre-processing
## Resampling: Cross-Validated (5 fold) 
## Summary of sample sizes: 800, 801, 800, 799, 800 
## Addtional sampling using ROSE
## 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy   Kappa    
##    2    0.9560146  0.4410583
##    8    0.9589745  0.5220785
##   15    0.9459944  0.3648353
## 
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 8.
```


```r
confusionMatrix(mod_rose)
```

```
## Cross-Validated (5 fold) Confusion Matrix 
## 
## (entries are percentual average cell counts across resamples)
##  
##           Reference
## Prediction Class1 Class2
##     Class1   93.7    0.5
##     Class2    3.6    2.2
##                            
##  Accuracy (average) : 0.959
```


```r
confusionMatrix(
  data = predict(mod_rose, tst),
  reference = tst$Class
)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Class1 Class2
##     Class1   9093     25
##     Class2    632    250
##                                           
##                Accuracy : 0.9343          
##                  95% CI : (0.9293, 0.9391)
##     No Information Rate : 0.9725          
##     P-Value [Acc > NIR] : 1               
##                                           
##                   Kappa : 0.4073          
##                                           
##  Mcnemar's Test P-Value : <2e-16          
##                                           
##             Sensitivity : 0.9350          
##             Specificity : 0.9091          
##          Pos Pred Value : 0.9973          
##          Neg Pred Value : 0.2834          
##              Prevalence : 0.9725          
##          Detection Rate : 0.9093          
##    Detection Prevalence : 0.9118          
##       Balanced Accuracy : 0.9221          
##                                           
##        'Positive' Class : Class1          
## 
```


```r
rf_mod = randomForest(
  Class ~ ., data = trn,
  strata = trn$Class,
  sampsize = c(1, 1),
  mtry = 1,
  ntree = 2500
)
rf_mod
```

```
## 
## Call:
##  randomForest(formula = Class ~ ., data = trn, strata = trn$Class,      sampsize = c(1, 1), mtry = 1, ntree = 2500) 
##                Type of random forest: classification
##                      Number of trees: 2500
## No. of variables tried at each split: 1
## 
##         OOB estimate of  error rate: 3.5%
## Confusion matrix:
##        Class1 Class2 class.error
## Class1    956     17  0.01747174
## Class2     18      9  0.66666667
```


```r
predict(rf_mod) == "Class2"
```

```
##    [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [25] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [37] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [49] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
##   [61] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [85] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##   [97] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [109] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [121] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [133] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [145] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [157] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [169] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [193] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
##  [205] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
##  [217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [229] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [241] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [253] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [265] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [277] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
##  [289] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [301] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [313] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [325] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [337] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [349] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [361] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [373] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
##  [385] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [397] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [409] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [421] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [433] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [445]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [457] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [469] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [481] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [493] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [505] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [517] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [529] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [541] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [553] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [565]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [577] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [589] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [601] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##  [613] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [625] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##  [637] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [649] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [661] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [673] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [685] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [697] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [709] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [721] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [733] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##  [745] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [757] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [769] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [781] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [793] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [805] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [817] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [829] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [841] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [853] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [865] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [877] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [889] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [901] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [913]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [925] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [937] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [949] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [961] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [973] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [985] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [997] FALSE FALSE FALSE FALSE
```



```r
rf_mod
```

```
## 
## Call:
##  randomForest(formula = Class ~ ., data = trn, strata = trn$Class,      sampsize = c(1, 1), mtry = 1, ntree = 2500) 
##                Type of random forest: classification
##                      Number of trees: 2500
## No. of variables tried at each split: 1
## 
##         OOB estimate of  error rate: 3.5%
## Confusion matrix:
##        Class1 Class2 class.error
## Class1    956     17  0.01747174
## Class2     18      9  0.66666667
```

