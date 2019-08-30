# Computing



This is not a book about R. It is however, a book that uses R. Because of this, you will need to be familiar with R. The text will point out some thing about R along the way, but some previous study of R is necessary.

The following (freely availible) readings are highly recommended:

- [Hands-On Programming with R](https://rstudio-education.github.io/hopr/) - *Garrett Grolemund*
    - If you have never used R or RStudio before, Part 1, Chapters 1 - 3, will be useful.
- [R for Data Science](https://r4ds.had.co.nz/) - *Garrett Grolemund, Hadley Wickham*
    - This book helps getting you up to speed working with data in R. While it is a lot of reading, Chapters 1 - 21 are highly recommended. 
- [Advanced R](https://adv-r.hadley.nz/) - *Hadley Wickham*
    - Part I, Chapters 1 - 8, of this book will help create a mental model for working with R. These chapters are not an easy read, so they should be returned to often. (Chapter 2 could be safely skipped for our purposes, but is important if you will use R in the long term.)

If you are a UIUC student who took the course STAT 420, the first six chapters of that book could serve as a nice refresher.

- [Applied Statistics with R](https://daviddalpiaz.github.io/appliedstats/) - *David Dalpiaz*

***

## Resources

The following resources are more specific or more advanced, but could still prove to be useful.

### R

- [Efficient R programming](https://csgillespie.github.io/efficientR/)
- [R Programming for Data Science](https://bookdown.org/rdpeng/rprogdatascience/)
- [R Graphics Cookbook](https://r-graphics.org/)
- [Modern Dive](https://moderndive.com/index.html)
- [The `tidyverse` Website](tidyverse.org/)
    - [`dplyr` Website](https://dplyr.tidyverse.org/)
    - [`readr` Website](https://readr.tidyverse.org/)
    - [`tibble` Website](https://tibble.tidyverse.org/)
    - [`forcats` Website](https://forcats.tidyverse.org/)

### RStudio

- [RStudio IDE Cheatsheet](https://resources.rstudio.com/rstudio-cheatsheets/rstudio-ide-cheat-sheet)
- [RStudio Resources](https://resources.rstudio.com/)

### R Markdown

- [R Markdown Cheatsheet](https://resources.rstudio.com/rstudio-cheatsheets/rmarkdown-2-0-cheat-sheet)
- [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/) - *Yihui Xie, J. J. Allaire, Garrett Grolemund*
- [R4DS R Markdown Chapter](https://r4ds.had.co.nz/r-markdown.html)

#### Markdown

- [Daring Fireball - Markdown: Basics](https://daringfireball.net/projects/markdown/basics)
- [GitHub - Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [CommonMark](https://commonmark.org/)

***

## BSL Idioms

Things here supercede everythign above.

### Reference Style

- [`tidyverse` Style Guide](https://style.tidyverse.org/)

### BSL Style Overrides

- TODO: `=` instead of `<-`
    - http://thecoatlessprofessor.com/programming/an-opinionated-tale-of-why-you-should-replace---with-/
- TODO: never use `T` or `F`, only `TRUE` or `FALSE`


```r
FALSE == TRUE
```

```
## [1] FALSE
```

```r
F     == TRUE
```

```
## [1] FALSE
```

```r
F     =  TRUE
F     == TRUE
```

```
## [1] TRUE
```

- TODO: never ever ever use `attach()`
- TODO: never ever ever use `<<-`
- TODO: never ever ever use `setwd()` or set a working directory some other way
- TODO: a newline before and after any chunk
- TODO: use headers appropriately! (short names, good structure)
- TODO: never ever ever put spaces in filenames. use `-`. (others will use `_`.)
- TODO: load all needed packages at the beginning of an analysis in a single chunk (TODO: pros and cons of this approach)
- TODO: one plot per chunk! no other printed output

Be consistent...

- with yourself!
- with your group!
- with your organization!


```r
set.seed(1337);mu=10;sample_size=50;samples=100000;
x_bars=rep(0, samples)
for(i in 1:samples)
{
x_bars[i]=mean(rpois(sample_size,lambda = mu))}
x_bar_hist=hist(x_bars,breaks=50,main="Histogram of Sample Means",xlab="Sample Means",col="darkorange",border = "dodgerblue")
mean(x_bars>mu-2*sqrt(mu)/sqrt(sample_size)&x_bars<mu+2*sqrt(mu)/sqrt(sample_size))
```

### Objects and Functions

> To understand computations in R, two slogans are helpful:
> 
> - Everything that exists is an object. 
> - Everything tha thappens is a function call. 
>
> — John Chambers

### Print versus Return


```r
cars_mod = lm(dist ~ speed, data = cars)
```


```r
summary(cars_mod)
```

```
## 
## Call:
## lm(formula = dist ~ speed, data = cars)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -29.069  -9.525  -2.272   9.215  43.201 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
## speed         3.9324     0.4155   9.464 1.49e-12 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 15.38 on 48 degrees of freedom
## Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
## F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12
```


```r
is.list(summary(cars_mod))
```

```
## [1] TRUE
```


```r
names(summary(cars_mod))
```

```
##  [1] "call"          "terms"         "residuals"     "coefficients" 
##  [5] "aliased"       "sigma"         "df"            "r.squared"    
##  [9] "adj.r.squared" "fstatistic"    "cov.unscaled"
```


```r
str(summary(cars_mod))
```

```
## List of 11
##  $ call         : language lm(formula = dist ~ speed, data = cars)
##  $ terms        :Classes 'terms', 'formula'  language dist ~ speed
##   .. ..- attr(*, "variables")= language list(dist, speed)
##   .. ..- attr(*, "factors")= int [1:2, 1] 0 1
##   .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. ..$ : chr [1:2] "dist" "speed"
##   .. .. .. ..$ : chr "speed"
##   .. ..- attr(*, "term.labels")= chr "speed"
##   .. ..- attr(*, "order")= int 1
##   .. ..- attr(*, "intercept")= int 1
##   .. ..- attr(*, "response")= int 1
##   .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
##   .. ..- attr(*, "predvars")= language list(dist, speed)
##   .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
##   .. .. ..- attr(*, "names")= chr [1:2] "dist" "speed"
##  $ residuals    : Named num [1:50] 3.85 11.85 -5.95 12.05 2.12 ...
##   ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
##  $ coefficients : num [1:2, 1:4] -17.579 3.932 6.758 0.416 -2.601 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:2] "(Intercept)" "speed"
##   .. ..$ : chr [1:4] "Estimate" "Std. Error" "t value" "Pr(>|t|)"
##  $ aliased      : Named logi [1:2] FALSE FALSE
##   ..- attr(*, "names")= chr [1:2] "(Intercept)" "speed"
##  $ sigma        : num 15.4
##  $ df           : int [1:3] 2 48 2
##  $ r.squared    : num 0.651
##  $ adj.r.squared: num 0.644
##  $ fstatistic   : Named num [1:3] 89.6 1 48
##   ..- attr(*, "names")= chr [1:3] "value" "numdf" "dendf"
##  $ cov.unscaled : num [1:2, 1:2] 0.19311 -0.01124 -0.01124 0.00073
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:2] "(Intercept)" "speed"
##   .. ..$ : chr [1:2] "(Intercept)" "speed"
##  - attr(*, "class")= chr "summary.lm"
```


```r
# RStudio only
View(summary(cars_mod))
```

### Help

- TODO: `?`, google, stack overflow, (office hours, course forums)

### Keyboard Shortcuts

- TODO: copy-paste, switch program, switch tab, etc...
- TODO: TAB!!!
- TODO: new chunk!
- TODO: style!
- TODO: keyboard shortcut for keyboard shortcut

***
