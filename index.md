---
title: "Basics of Statistical Learning"
author: "[David Dalpiaz](https://daviddalpiaz.org/)"
# date: "2020-08-31"
github-repo: daviddalpiaz/bsl
url: 'https\://statisticallearning.org/'
site: bookdown::bookdown_site
bibliography: [book.bib]
citation-style: chicago-fullnote-bibliography.csl
link-citations: yes
output:
  bookdown::gitbook:
    # pandoc_args: [--katex]
    mathjax: true
    # includes:
    #   in_header: katex.html
documentclass: book
math: true
---

# Welcome {-}

Welcome to Basics of Statistical Learning! What a boring title! The title was chosen to mirror that of the [University of Illinois at Urbana-Champaign](https://illinois.edu/) course [STAT 432 - Basics of Statistical Learning](https://stat432.org/). That title was chosen to meet certain University course naming conventions, hence the boring title. A more appropriate title would be *a broad introduction to machine learning from the perspective of a statistician who uses R^[@r-base] and emphasizes practice over theory*. This is more descriptive, still boring, and way too many words. Anyway, this "book" will be referred to as **BSL** for short.

This chapter will outline the **who**, **what**, **when**, **where**, **why**, and **how**^[Wikipedia: [Five Ws](https://en.wikipedia.org/wiki/Five_Ws)] of this book, but not necessarily in that order.

## Who?

### Readers

This book is targeted at advanced undergraduate or first year MS students in Statistics who have *no prior machine learning experience*. While both will be discussed in great detail, previous experience with both statistical modeling and R are assumed. In other words, this books is for students in STAT 432^[STAT 432 is also cross-listed as ASRM 451, but we will exclusively refer to STAT 432 for simplicity.].

If you are reading this book but are not involved in STAT 432, we assume:

- a semester of calculus based probability and statistics
- familiarity with linear algebra
- enough understanding of linear models and R to be able to use R's formula syntax to specify models

### Author

This text was written by [David Dalpiaz](https://daviddalpiaz.org/)^[He does not enjoy writing about himself].

### Acknowledgements

The following is a (likely incomplete) list of helpful contributors. This book was also influenced by the helpful [contributors to R4SL](https://daviddalpiaz.github.io/r4sl/index.html#acknowledgements).

<!-- TODO: Simply list R4Sl contributors here. -->
<!-- TODO: Add all former TAs and CAs of STAT 432. -->

- [Jae-Ho Lee](https://www.linkedin.com/in/jae-ho-lee-32052710b/) - STAT 432, Fall 2019
- [W. Jonas Reger](https://www.linkedin.com/in/wjonasreger/) - STAT 432, Spring 2020

Please see the [CONTRIBUTING](https://github.com/daviddalpiaz/bsl/blob/master/CONTRIBUTING.md) document on GitHub for details on interacting with this project. Pull requests encouraged!

<!-- Looking for ways to contribute? -->

<!-- - You'll notice that a lot of the plotting code is not displayed in the text, but is available in the source. Currently that code was written to accomplish a task, but without much thought about the best way to accomplish the task. Try re-factoring some of this code. -->
<!-- - Fix typos. Since the book is actively being developed, typos are getting added all the time. -->
<!-- - Suggest edits. Good feedback can be just as helpful as actually contributing code changes. -->

<!-- TODO: Standing on the shoulder of giants. High level acknowledgments. -->

## What?

Well, this is a book. But you already knew that. More specifically, this is a book for use in STAT 432. But if you are reading this chapter, you're either not in STAT 432, or new to STAT 432, so that isn't really helpful. This is a book about machine learning. But this is too vague a description. It is probably most useful to describe the desired outcome as a result of reading this book. In a single sentence:

> After engaging with BSL, readers should feel comfortable **training** predictive models and **evaluating** their use as part of larger systems or data anlyses.

This sentence is both too specific and too general, so some additional comments about what will and will not be discussed in this text:

- An ability to **train** models will be emphasized over the ability to *understand* models at a deep theoretical level. This is not to say that theory will be completely ignored, but some theory will be sacrificed for practicality. Theory^[Theory here is ill defined. Loosely, "theory" is activities that are closer to writing theorem-proof mathematics while "practice" is more akin to using built-in statistical computing tools in a language like R.] will be explored especially when it motivates use in practice.
- **Evaluation** of models is emphasized as the author takes the position^[[This is not a unique opinion.](https://twitter.com/PhDemetri/status/1235380313272070144)] that in practice it is more important to know *if* your model works than *how* your model works.
- Rather than making an attempt to illustrate all possible modeling techniques^[This is impossible.], a small set of techniques are emphasized: linear models, nearest neighbors, and decision trees. These will initially serve as examples for theory discussions, but will then become the building blocks for more complex techniques such as lasso, ridge, and random forests.
- While the set of models discussed will be limited^[Students often ask if we will cover support vector machines or deep learning or *insert latest buzzword model here*. The author believes this is because students consider these to be "cool" methods. One of the goals of this text is to make machine learning seems as uncool as possible. The hope would be for readers to understand something like an SVM to be "just another method" which also needs to be **evaluated**. The author believes deep learning is useful, but would clutter the presentation because of the additional background and computing that would need to be introduced. Follow-up learning of deep learning is encouraged after reading BSL. Hopefully, by reading BSL, getting up to speed *using* deep learning will be made easier.], the emphasis on an ability to train and evaluate these models should allow a reader to train and evaluate **any** model in a predictive context, provided it is implemented in a statistical computing environment^[Also provided the user reads the documentation.].

For a better understanding of the specific topics covered, please see the next chapter which serves as an overview of the text.

To be clear: This book is not an exhaustive treatment of machine learning. If this is your first brush with machine learning, hopefully it is not your last!

## Why?

*Why does this book exists?* That is a very good question, especially given the existence of [*An Introduction to Statistical Learning*](https://faculty.marshall.usc.edu/gareth-james/ISL/)^[@james2013introduction], the immensely popular book^[This book is generally referred to as **ISL**.] by James, Witten, Hastie, and Tibshirani. The author of this text believes ISL is a great text^[He has spent so much time referencing ISL that he found and suggested a [typo fix](https://faculty.marshall.usc.edu/gareth-james/ISL/errata.html).], so much so that he would suggest that any readers of BSL also read all of ISL^[One of the biggest strengths of ISL is its readability.]. Despite this, a book that was more inline with the content and goals of STAT 432^[The biggest differences are: Assumed reader background, overall structure, and R code usage and style.] was conceived by the author, so here we are.

*Why does STAT 432 exist?* Short answer: to add a course on machine learning to the undergraduate Statistics curriculum at the University of Illinois. The long story is long, but two individuals deserve credit for their work in the background:

- [Ehsan Bokhari](https://www.mlb.com/astros/team/front-office/ehsan-bokhari) for introducing the author to ISL and suggesting that it would make a good foundation for an undergraduate course.
- [Jeff Douglas](https://stat.illinois.edu/directory/profile/jeffdoug) for actually getting the pilot version of STAT 432 off the ground^[Jeff taught the first proto-version of STAT 432 as a topics course, but then allowed the author to take over teaching and development while he worked to get the course fully approved.].

## Where?

Currently, this text is used exclusively^[If you are using this text elsewhere, that's great! Please let the author know!] for STAT 432^[<https://stat432.org/>] at the University of Illinois at Urbana-Champaign.

The text can be accessed from <https://statisticallearning.org/>.

## When?

This book was last updated on: 2020-08-31.^[The author has no idea what else to write in this section, but the last updated date seems like useful information.]

## How?

Knowing a bit about how this book was built will help readers better interact with the text.

### Build Tools

This book is authored using Bookdown^[@bookdown], built using [Travis-CI](https://travis-ci.com/), and hosted via [GitHub pages](https://pages.github.com/). Details of this setup can be found by browser the relevant GitHub repository.^[https://github.com/daviddalpiaz/bsl]

Users that are familiar with these tools, most importantly GitHub, are encouraged to contribute. As noted above, please see the [CONTRIBUTING](https://github.com/daviddalpiaz/bsl/blob/master/CONTRIBUTING.md) document on GitHub for details on interacting with this project.

### Active Development

**This "book" is under active development.** Literally every element of the book is subject to change, at any moment. This text, BSL, is the successor to [R4SL](https://daviddalpiaz.github.io/r4sl/), an unfinished work that began as a supplement to [Introduction to Statistical Learning](https://faculty.marshall.usc.edu/gareth-james/ISL/), but was never finished. (In some sense, this book is just a fresh start due to the author wanting to change the presentation of the material. The author is seriously worried that he will encounter the second-system effect.^[Wikipedia: [Second-System Effect](https://en.wikipedia.org/wiki/Second-system_effect)]

Because this book is written with a course in mind, that is actively being taught, often out of convenience the text will speak directly to the students of that course. Thus, be aware that any references to a "course" are a reference to [STAT 432 @ UIUC](www.stat432.org).

Since this book is under active development you may encounter errors ranging from typos, to broken code, to poorly explained topics. If you do, please let us know! Better yet, fix the issue yourself!^[Yihui Xie: [You Do Not Need to Tell Me I Have A Typo in My Documentation](https://yihui.name/en/2013/06/fix-typo-in-documentation/)] If you are familiar with R Markdown and GitHub, [pull requests are highly encouraged!](https://github.com/daviddalpiaz/bsl). This process is partially automated by the edit button in the top-left corner of the html version. If your suggestion or fix becomes part of the book, you will be added to the acknowledgments in this chapter this chapter. We’ll also link to your GitHub account, or personal website upon request. If you're not familiar with version control systems feel free to email the author, `dalpiaz2 AT illinois DOT edu`.^[But also consider using this opportunity to learn a bit about version control!] See additional details in the Acknowledgments section above.

While development is taking place, you may see "TODO" items scattered throughout the text. These are mostly notes for internal use, but give the reader some idea of what development is still to come.

### Packages

The following will install all R packages needed to follow along with the text.


```r
install.packages(
  "tidyverse",
  "kableExtra",
  "GGally",
  "ISLR",
  "klaR",
  "rpart",
  "rpart.plot",
  "caret",
  "ellipse",
  "gbm"
)
```

### License

![This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/)](img/cc.png) 
