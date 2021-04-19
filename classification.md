# Classification



This chapter continues our discussion of **supervised learning** by introducing the **classification** tasks. Like regression, we will focus on the conditional distribution of the response.

Specifically, we will discuss:

- The setup for the **classification** task.
- The **Bayes classifier** and **Bayes error**.
- Estimating **conditional probabilities**.
- Two simple **metrics** for the classification task.

This chapter is currently under construction. While it is being developed, the following links to the STAT 432 course notes.

- [**Notes:** Classification](files/classification.pdf)

## R Setup and Source


```r
library(tibble)     # data frame printing
library(dplyr)      # data manipulation

library(knitr)      # creating tables
library(kableExtra) # styling tables
```

Additionally, objects from `ggplot2`, `GGally`, and `ISLR` are accessed. Recall that the [Welcome](index.html) chapter contains directions for installing all necessary packages for following along with the text. The R Markdown source is provided as some code, mostly for creating plots, has been suppressed from the rendered document that you are currently reading.

- **R Markdown Source:** [`classification.Rmd`](classification.Rmd)

## Data Setup

- TODO: Add data setup example.

## Mathematical Setup

## Example

<table class="table table-striped" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> $X = 1$ </th>
   <th style="text-align:right;"> $X = 2$ </th>
   <th style="text-align:right;"> $X = 3$ </th>
   <th style="text-align:right;"> $X = 4$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;background-color: white !important;border-right:1px solid;"> $Y = A$ </td>
   <td style="text-align:right;"> 0.12 </td>
   <td style="text-align:right;"> 0.01 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 0.14 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;background-color: white !important;border-right:1px solid;"> $Y = B$ </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:right;"> 0.10 </td>
   <td style="text-align:right;"> 0.15 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;background-color: white !important;border-right:1px solid;"> $Y = C$ </td>
   <td style="text-align:right;"> 0.09 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> 0.08 </td>
   <td style="text-align:right;"> 0.13 </td>
  </tr>
</tbody>
</table>

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> $X = 1$ </th>
   <th style="text-align:right;"> $X = 2$ </th>
   <th style="text-align:right;"> $X = 3$ </th>
   <th style="text-align:right;"> $X = 4$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 0.1 </td>
   <td style="text-align:right;"> 0.22 </td>
   <td style="text-align:right;"> 0.42 </td>
  </tr>
</tbody>
</table>

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> $Y = A$ </th>
   <th style="text-align:right;"> $Y = B$ </th>
   <th style="text-align:right;"> $Y = C$ </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 0.31 </td>
   <td style="text-align:right;"> 0.33 </td>
   <td style="text-align:right;"> 0.36 </td>
  </tr>
</tbody>
</table>

## Bayes Classifier

$$
p_k(x) = P\left[ Y = k \mid X = x \right]
$$

$$
C^B(x) = \underset{k \in \{1, 2, \ldots K\}}{\text{argmax}} P\left[ Y = k \mid X = x \right]
$$

**Warning:** The Bayes classifier should not be confused with a naive Bayes classifier. The Bayes classifier assumes that we know $P\left[ Y = k \mid X = x \right]$ which is almost never known in practice. A naive Bayes classifier is a method we will see later that learns a classifier from data.^[This author feels that the use of "Bayes" in "Bayes classifier" is actually confusing because you don't actually need to apply Bayes' theorem to state or understand the result. Meanwhile, Bayes' theorem is needed to understand the naive Bayes classifier. Oh well. Naming things is hard.]

***

### Bayes Error Rate

$$
1 - \mathbb{E}_X\left[ \underset{k}{\text{max}} \ P[Y = k \mid X = x] \right]
$$

## Building a Classifier

$$
\hat{p}_k(x) = \hat{P}\left[ Y = k \mid X = x \right]
$$

$$
\hat{C}(x) = \underset{k \in \{1, 2, \ldots K\}}{\text{argmax}} \hat{p}_k(x)
$$

- TODO: first estimation conditional distribution, then classify to label with highest probability
- TODO: do it in r with knn, tree, or glm / nnet
- TODO: note about estimating probabilities vs training a classifier

## Modeling

### Linear Models

- TODO: use `nnet::multinom`
    - in place of `glm()`? always?

### k-Nearest Neighbors

- TODO: use `caret::knn3()`

### Decision Trees

- TODO: use `rpart::rpart()`

## Classification Metrics

Like regression, classification metrics will depend on the learned function (in this case, the learned classifier $\hat{C}$) as well as an additional dataset that is being used to make classifications with the learned function.^[The metrics also implicitly depend on the dataset used to learn the classifier.] Like regression, this will make the notation for a "simple" metric like accuracy look significantly more complicated than it truly is, but it will be helpful to make the dependency on the datasets explicit.

### Misclassification

$$
\text{miclass}\left(\hat{C}_{\texttt{set_f}}, \mathcal{D}_{\texttt{set_D}} \right) = \frac{1}{n_{\texttt{set_D}}}\displaystyle\sum_{i \in {\texttt{set_D}}}^{} I\left(y_i \neq \hat{C}_{\texttt{set_f}}({x}_i)\right)
$$


```r
calc_misclass = function(actual, predicted) {
  mean(actual != predicted)
}
```

### Accuracy

$$
\text{accuracy}\left(\hat{C}_{\texttt{set_f}}, \mathcal{D}_{\texttt{set_D}} \right) = \frac{1}{n_{\texttt{set_D}}}\displaystyle\sum_{i \in {\texttt{set_D}}}^{} I\left(y_i = \hat{C}_{\texttt{set_f}}({x}_i)\right)
$$


```r
calc_accuracy = function(actual, predicted) {
  mean(actual == predicted)
}
```

Plugging in the appropriate dataset will allow for calculation of train, test, and validation metrics.




















































