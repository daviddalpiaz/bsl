# Machine Learning Overview





***

STAT 432 is a course about machine learning? Let's try to define machine learning.

***

## Reading

- **Required:** [ISL Chapter 1](https://faculty.marshall.usc.edu/gareth-james/ISL/ISLR%20Seventh%20Printing.pdf)
- **Required:** [ISL Chapter 2](https://faculty.marshall.usc.edu/gareth-james/ISL/ISLR%20Seventh%20Printing.pdf)
  - This chapter is dense because it is an overview of the entire book. Do not expect to completely understand this chapter during a first read. We will spend the rest of the semester elaborating on these concepts. However, seeing them at the beginning will be helpful.
- **Recommended:** [Variance Explained: What's the difference between data science, machine learning, and artificial intelligence?](http://varianceexplained.org/r/ds-ml-ai/)

***

## What is Machine Learning?

Machine learning (ML) is about **learning _functions_ from _data_**. That's it. Really. Pretty boring, right?

To quickly address some buzzwords that come up when discussing machine learning:

- **Deep learning** is just a subset of machine learning.
- **Artificial Intelligence** (AI) overlaps machine learning but has much loftier goals. In general, if someone claims to be using AI, they are not. (They're probably using function learning! For example, we will learn logistic regression in this course. People in marketing might call that AI! Someone who understands ML will simply call it function learning. Don't buy the hype! We don't need to call simple methods AI to make them effective.)
- Machine learning is not **data science**. Data science sometimes uses machine learning.
- Does **big data** exist? If it does, I would bet a lot of money that you haven't seen it, and probably won't see it that often.
- **Analytics** is just a fancy word for doing data analysis. Machine learning can be used in analyses! When it is, it is often called "Predictive Analytics."

What makes machine learning interesting are the uses of these functions. We could develop functions that have applications in a wide variety of fields.

In **medicine**, we could develop a function that helps detect skin cancer.

- Input: Pixels from an image of mole
- Output: A probability of skin cancer

In **sport analytics**, we could develop a function that helps determine player salary.

- Input: Lifetime statistics of an NBA player
- Output: An estimate of player's salary

In **meteorology**, we could develop a function to predict the weather.

- Input: Historic weather data in Champaign, IL
- Output: A probability of rain tomorrow in Champaign, IL

In **political science** we could develop a function that predicts the mood of the president.

- Input: The text of a tweet from President Donald Trump
- Output: A prediction of Donald's mood (happy, sad, angry, etc)

In **urban planning** we could develop a function that predicts the rental prices of Airbnbs.

- Input: The attributes of the location for rent
- Output: An estimate of the rent of the property

How do we learn these functions? By looking at many previous examples, that is, data! Again, we will learn functions from data. That's what we're here to do.

***

## Machine Learning Tasks

When doing machine learning, we will classify our *tasks* into one of two categories, **supervised** or **unsupervised** learning. (There are technically other tasks such as reinforcement learning and semi-supervised learning, but they are outside the scope of this text. To understand these advanced tasks, you should first learn the basics!) Within these two broad categories of ML tasks, we will define some specifics.



### Supervised Learning

In supervised learning, we want to "predict" a specific *response variable*. (The response variable might also be called the target or outcome variable.) In the following examples, this is the `y` variable. Supervised learning tasks are called **regression** if the response variable is *numeric*. If a supervised learning tasks has a *categorical* response, it is called **classification**.

#### Regression

In the regression task, we want to predict **numeric** response variables. The predictor variables, which we will call the feature variables, or simply **features** can be either *categorical* or *numeric*.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> x1 </th>
   <th style="text-align:right;"> x2 </th>
   <th style="text-align:right;"> x3 </th>
   <th style="text-align:right;"> y </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> -0.66 </td>
   <td style="text-align:right;"> 0.48 </td>
   <td style="text-align:right;"> 14.09 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> 1.55 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 2.92 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> -1.19 </td>
   <td style="text-align:right;"> -0.81 </td>
   <td style="text-align:right;"> 15.00 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:right;"> 0.28 </td>
   <td style="text-align:right;"> 9.29 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:right;"> -1.09 </td>
   <td style="text-align:right;"> -0.16 </td>
   <td style="text-align:right;"> 17.57 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:right;"> 1.61 </td>
   <td style="text-align:right;"> 1.94 </td>
   <td style="text-align:right;"> 2.12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:right;"> 1.72 </td>
   <td style="text-align:right;"> 8.92 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> 1.31 </td>
   <td style="text-align:right;"> 0.36 </td>
   <td style="text-align:right;"> 4.40 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:right;"> 0.98 </td>
   <td style="text-align:right;"> 0.30 </td>
   <td style="text-align:right;"> 4.40 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:right;"> 0.88 </td>
   <td style="text-align:right;"> -0.39 </td>
   <td style="text-align:right;"> 4.52 </td>
  </tr>
</tbody>
</table>

With the data above, our goal would be to learn a function that takes as input values of the three features (`x1`, `x2`, and `x3`) and returns a prediction (best guess) for the true (but usually unknown) value of the response `y`. For example, we could obtain some "new" data that does not contain the response.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> x1 </th>
   <th style="text-align:right;"> x2 </th>
   <th style="text-align:right;"> x3 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:right;"> -0.85 </td>
   <td style="text-align:right;"> -2.41 </td>
  </tr>
</tbody>
</table>

We would then pass this data to our function, which would return a prediction of the value of `y`. Stated mathematically, our prediction will often be an estimate the conditional mean of $Y$, given values of the $\boldsymbol{X}$ variables. 

$$
\mu(\boldsymbol{x}) = \mathbb{E}[Y \mid \boldsymbol{X} = \boldsymbol{x}]
$$

In other words, we want to learn this function, $\mu(\boldsymbol{x})$. Much more on this later. (You can safely ignore this for now.)

#### Classification

Classification is similar to regression, except it considers **categorical** response variables. 

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> x1 </th>
   <th style="text-align:right;"> x2 </th>
   <th style="text-align:right;"> x3 </th>
   <th style="text-align:left;"> y </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Q </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 5.42 </td>
   <td style="text-align:left;"> B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Q </td>
   <td style="text-align:right;"> 0.72 </td>
   <td style="text-align:right;"> 0.83 </td>
   <td style="text-align:left;"> C </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Q </td>
   <td style="text-align:right;"> 0.93 </td>
   <td style="text-align:right;"> 5.93 </td>
   <td style="text-align:left;"> B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Q </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 5.68 </td>
   <td style="text-align:left;"> A </td>
  </tr>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:left;"> B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:right;"> 0.94 </td>
   <td style="text-align:right;"> 3.09 </td>
   <td style="text-align:left;"> B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:right;"> 0.98 </td>
   <td style="text-align:right;"> 2.34 </td>
   <td style="text-align:left;"> C </td>
  </tr>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:right;"> 0.12 </td>
   <td style="text-align:right;"> 5.43 </td>
   <td style="text-align:left;"> C </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Q </td>
   <td style="text-align:right;"> 0.47 </td>
   <td style="text-align:right;"> 2.68 </td>
   <td style="text-align:left;"> B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:right;"> 0.56 </td>
   <td style="text-align:right;"> 5.02 </td>
   <td style="text-align:left;"> B </td>
  </tr>
</tbody>
</table>

As before we want to learn a function from this data using the same inputs, except this time, we want it to output one of `A`, `B`, or `C` for predictions of the `y` variable. Again, consider some new data:

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> x1 </th>
   <th style="text-align:right;"> x2 </th>
   <th style="text-align:right;"> x3 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> P </td>
   <td style="text-align:right;"> 0.96 </td>
   <td style="text-align:right;"> 5.33 </td>
  </tr>
</tbody>
</table>

While ultimately we would like our function to return one of `A`, `B`, or `C`, what we actually would like is an intermediate return of probabilities that `y` is `A`, `B`, or `C`. In other words, we are attempting to estimate the conditional probability that $Y$ is each of the possible categories, given values of the $\boldsymbol{X}$ values.

$$
p_k(\boldsymbol{x}) = P\left[ Y = k \mid \boldsymbol{X} = \boldsymbol{x} \right]
$$

We want to learn this function, $p_k(\boldsymbol{x})$. Much more on this later. (You can safely ignore this for now.)

### Unsupervised Learning

Unsupervised learning is a very broad task that is rather difficult to define. Essentially, it is learning without a response variable. To get a better idea about what unsupervised learning is, consider some specific tasks. 

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> x1 </th>
   <th style="text-align:right;"> x2 </th>
   <th style="text-align:right;"> x3 </th>
   <th style="text-align:right;"> x4 </th>
   <th style="text-align:right;"> x5 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2.74 </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 5.42 </td>
   <td style="text-align:right;"> 4.43 </td>
   <td style="text-align:right;"> 2.28 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2.81 </td>
   <td style="text-align:right;"> 0.72 </td>
   <td style="text-align:right;"> 0.83 </td>
   <td style="text-align:right;"> 4.87 </td>
   <td style="text-align:right;"> 2.61 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0.86 </td>
   <td style="text-align:right;"> 0.93 </td>
   <td style="text-align:right;"> 5.93 </td>
   <td style="text-align:right;"> 2.33 </td>
   <td style="text-align:right;"> 0.22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2.49 </td>
   <td style="text-align:right;"> 0.26 </td>
   <td style="text-align:right;"> 5.68 </td>
   <td style="text-align:right;"> 4.11 </td>
   <td style="text-align:right;"> 5.84 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1.93 </td>
   <td style="text-align:right;"> 0.46 </td>
   <td style="text-align:right;"> 0.49 </td>
   <td style="text-align:right;"> 0.02 </td>
   <td style="text-align:right;"> 2.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> -8.44 </td>
   <td style="text-align:right;"> -9.06 </td>
   <td style="text-align:right;"> -6.91 </td>
   <td style="text-align:right;"> -5.00 </td>
   <td style="text-align:right;"> -4.25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> -7.79 </td>
   <td style="text-align:right;"> -9.02 </td>
   <td style="text-align:right;"> -7.66 </td>
   <td style="text-align:right;"> -9.96 </td>
   <td style="text-align:right;"> -4.67 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> -9.60 </td>
   <td style="text-align:right;"> -9.88 </td>
   <td style="text-align:right;"> -4.57 </td>
   <td style="text-align:right;"> -8.75 </td>
   <td style="text-align:right;"> -6.16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> -8.03 </td>
   <td style="text-align:right;"> -9.53 </td>
   <td style="text-align:right;"> -7.32 </td>
   <td style="text-align:right;"> -4.56 </td>
   <td style="text-align:right;"> -4.17 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> -7.88 </td>
   <td style="text-align:right;"> -9.44 </td>
   <td style="text-align:right;"> -4.98 </td>
   <td style="text-align:right;"> -6.33 </td>
   <td style="text-align:right;"> -6.29 </td>
  </tr>
</tbody>
</table>

#### Clustering

Clustering is essentially the task of **grouping** the observations of a dataset. In the above data, can you see an obvious grouping? (Hint: Compare the first five observations to the second five observations.) In general, we try to group observations that are similar.

#### Density Estimation

Density estimation tries to do exactly what the name implies, estimate the density. In this case, the joint density of $X_1, X_2, X_3, X_4, X_5$. In other words, we would like to learn the **function** that generated this data. (You could take the position that this is the **only** machine learning tasks, and all other tasks are subset of this task. We'll hold off on explaining this for a while.)

#### Outlier Detection

Consider some new data:

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> x1 </th>
   <th style="text-align:right;"> x2 </th>
   <th style="text-align:right;"> x3 </th>
   <th style="text-align:right;"> x4 </th>
   <th style="text-align:right;"> x5 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 66.68 </td>
   <td style="text-align:right;"> 66.26 </td>
   <td style="text-align:right;"> 69.49 </td>
   <td style="text-align:right;"> 70 </td>
  </tr>
</tbody>
</table>

Was this data generated by the same process as the data above? If no, we would call it an outlier.

***

## Open Questions

The two previous sections were probably more confusing than helpful. But of course, because we haven't started learning yet! Hopefully, you are currently pondering one very specific question:

- *How* do we **learn** functions from data?

That's what this text will be about! We will spend a lot of time on this question. It is what us statisticians call fitting a model. On some level the answer is: look at a bunch of old data before predicting on new data. 

While we will dedicate a large amount of time to answering this question, sometimes, some of the details might go unanswered. Since this is an introductory text, we can only go so far. However, as long as we answer another question, this will be OK.

- *How* do we **evaluate** how well learned functions work?

This text places a high priority on being able to **do** machine learning, specifically do machine learning in R. You can actually do a lot of machine learning without fully understanding how the learning is taking place. That makes the *evaluation* of ML models extremely important.

## Source

- `R` Markdown: [`ml-overview.Rmd`](ml-overview.Rmd)

***
