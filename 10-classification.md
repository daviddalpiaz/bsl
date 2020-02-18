# Classification





***

In this chapter we will introduce **classification**. The main difference between classification and regression is the type of variable used as the response. In regression, we used a numeric response. In classification, we use a **categorical** response.

This chapter is not all of classification. We will spend many additional chapters uncovering details of classification.

***

## Reading

We're going to try something odd this week No reading! (At least for now. This is sort of the opposite of last week.) Instead, watch the video posted to the course website. Our goal is to show you that almost everything you learned in regression immediately transfers to performing classification. This video simply defines a few new terms and tasks. It might prove frustrating at first, but hopefully you will quickly realize the pattern. (If not, we'll explain in greater detail over the next week chapters and weeks.)

***

## Classification Metrics

**Misclassification** Rate


```r
calc_misclass = function(actual, predicted) {
  mean(actual != predicted)
}
```

**Accuracy**


```r
calc_accuracy = function(actual, predicted) {
  mean(actual == predicted)
}
```

***

## Source

- `R` Markdown: [`10-classification.Rmd`](10-classification.Rmd)

***
