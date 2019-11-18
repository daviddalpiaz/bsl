# Clustering: Basketball Players




```r
library(readr)
library(tibble)
library(dplyr)
library(purrr)
library(ggplot2)
library(ggridges)
library(lubridate)
library(randomForest)
library(rpart)
library(rpart.plot)
library(cluster)
library(caret)
library(factoextra)
library(rsample)
library(janitor)
library(rvest)
library(dendextend)
library(knitr)
library(kableExtra)
library(ggthemes)
```



- TODO: Show package messaging? check conflicts!
- TODO: Should this be split into three analyses with different packages?

## Background

- https://www.youtube.com/watch?v=cuLprHh_BRg
- https://www.youtube.com/watch?v=1FBwSO_1Mb8
- https://www.basketball-reference.com/leagues/NBA_2019.html
- inspiration here, and others: http://blog.schochastics.net/post/analyzing-nba-player-data-ii-clustering/

## Data

- https://www.basketball-reference.com/leagues/NBA_2019_totals.html
- https://www.basketball-reference.com/leagues/NBA_2019_per_minute.html
- https://www.basketball-reference.com/leagues/NBA_2019_per_poss.html
- https://www.basketball-reference.com/leagues/NBA_2019_advanced.html




```r
nba = scrape_nba_season_player_stats()
nba$pos = factor(nba$pos, levels = c("PG", "SG", "SF", "PF", "C"))
```


```
## # A tibble: 100 x 93
##    player_team pos     age tm        g    gs    mp    fg   fga fg_percent   x3p
##    <chr>       <fct> <dbl> <chr> <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl> <dbl>
##  1 Álex Abrin~ SG       25 OKC      31     2   588    56   157      0.357    41
##  2 Quincy Acy~ PF       28 PHO      10     0   123     4    18      0.222     2
##  3 Jaylen Ada~ PG       22 ATL      34     1   428    38   110      0.345    25
##  4 Steven Ada~ C        25 OKC      80    80  2669   481   809      0.595     0
##  5 Bam Adebay~ C        21 MIA      82    28  1913   280   486      0.576     3
##  6 Deng Adel ~ SF       21 CLE      19     3   194    11    36      0.306     6
##  7 DeVaughn A~ SG       25 DEN       7     0    22     3    10      0.3       0
##  8 LaMarcus A~ C        33 SAS      81    81  2687   684  1319      0.519    10
##  9 Rawle Alki~ SG       21 CHI      10     1   120    13    39      0.333     3
## 10 Grayson Al~ SG       23 UTA      38     2   416    67   178      0.376    32
## # ... with 90 more rows, and 82 more variables: x3pa <dbl>, x3p_percent <dbl>,
## #   x2p <dbl>, x2pa <dbl>, x2p_percent <dbl>, e_fg_percent <dbl>, ft <dbl>,
## #   fta <dbl>, ft_percent <dbl>, orb <dbl>, drb <dbl>, trb <dbl>, ast <dbl>,
## #   stl <dbl>, blk <dbl>, tov <dbl>, pf <dbl>, pts <dbl>, fg_pm <dbl>,
## #   fga_pm <dbl>, fg_percent_pm <dbl>, x3p_pm <dbl>, x3pa_pm <dbl>,
## #   x3p_percent_pm <dbl>, x2p_pm <dbl>, x2pa_pm <dbl>, x2p_percent_pm <dbl>,
## #   ft_pm <dbl>, fta_pm <dbl>, ft_percent_pm <dbl>, orb_pm <dbl>, drb_pm <dbl>,
## #   trb_pm <dbl>, ast_pm <dbl>, stl_pm <dbl>, blk_pm <dbl>, tov_pm <dbl>,
## #   pf_pm <dbl>, pts_pm <dbl>, fg_pp <dbl>, fga_pp <dbl>, fg_percent_pp <dbl>,
## #   x3p_pp <dbl>, x3pa_pp <dbl>, x3p_percent_pp <dbl>, x2p_pp <dbl>,
## #   x2pa_pp <dbl>, x2p_percent_pp <dbl>, ft_pp <dbl>, fta_pp <dbl>,
## #   ft_percent_pp <dbl>, orb_pp <dbl>, drb_pp <dbl>, trb_pp <dbl>,
## #   ast_pp <dbl>, stl_pp <dbl>, blk_pp <dbl>, tov_pp <dbl>, pf_pp <dbl>,
## #   pts_pp <dbl>, o_rtg_pp <dbl>, d_rtg_pp <dbl>, per <dbl>, ts_percent <dbl>,
## #   x3p_ar <dbl>, f_tr <dbl>, orb_percent <dbl>, drb_percent <dbl>,
## #   trb_percent <dbl>, ast_percent <dbl>, stl_percent <dbl>, blk_percent <dbl>,
## #   tov_percent <dbl>, usg_percent <dbl>, ows <dbl>, dws <dbl>, ws <dbl>,
## #   ws_48 <dbl>, obpm <dbl>, dbpm <dbl>, bpm <dbl>, vorp <dbl>
```

## EDA


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-7-1} \end{center}


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-8-1} \end{center}


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-9-1} \end{center}


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-10-1} \end{center}


```r
nba_for_clustering = nba %>% 
  filter(mp > 2000) %>%
  column_to_rownames("player_team") %>%
  select(-pos, -tm)
```

## Modeling


```r
set.seed(42)

# function to compute total within-cluster sum of square 
wss = function(k, data) {
  kmeans(x = data, centers = k, nstart = 10)$tot.withinss
}

# Compute and plot wss for k = 1 to k = 15
k_values = 1:15

# extract wss for 2-15 clusters
wss_values = map_dbl(k_values, wss, data = nba_for_clustering)

plot(k_values, wss_values,
       type = "b", pch = 19, frame = TRUE, 
       xlab = "Number of clusters K",
       ylab = "Total within-clusters sum of squares")
grid()
```



\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-12-1} \end{center}

- TODO: K-Means likes clusters of roughly equal size.
- TODO: http://varianceexplained.org/r/kmeans-free-lunch/


```r
nba_hc = hclust(dist(nba_for_clustering))
nba_hc_clust = cutree(nba_hc, k = 5)
table(nba_hc_clust)
```

```
## nba_hc_clust
##  1  2  3  4  5 
## 38 13 28 11  1
```

## Model Evaluation


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-14-1} \end{center}


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-15-1} \end{center}


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-16-1} \end{center}

## Discussion


\begin{center}\includegraphics{01-04-clustering_files/figure-latex/unnamed-chunk-17-1} \end{center}
