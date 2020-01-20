# Statistics



***

STAT 432 is a course about statistics, in particular, some specific statistics. To discuss the statistics of interest in STAT 432, we will need some general concepts about statistics.

**Note:** This section has been published while being nearly empty to provide easy access to a few definitions needed for Quiz 01.

***

## Reading

- **Reference:** [STAT 400](http://stat400.org)

***

<!-- - TODO: Where we are going, estimating conditional means and distributions. -->
<!-- - TODO: estimation = learning. "learning from data." what are we learning about? often parameters. -->
<!-- - TODO: <http://stat400.org> -->
<!-- - TODO: <http://stat420.org> -->

<!-- ## Statistics -->

<!-- - TODO: parameters are a function of the population distribution -->
<!-- - TODO: statistics are a function of data. -->
<!-- - TODO: parameters:population::statistics::data -->
<!-- - TODO: statistic vs value of a statistic -->

## Estimators

<!-- - TODO: estimator vs estimate -->

### Properties

#### Bias

$$
\text{bias}\left[\hat{\theta}\right] \triangleq
\mathbb{E}\left[\hat{\theta}\right] - \theta
$$

#### Variance

$$
\text{var}\left[\hat{\theta}\right] \triangleq
\mathbb{E}\left[ \left( \hat{\theta} - \mathbb{E}\left[\hat{\theta}\right] \right)^2 \right]
$$

#### Mean Squared Error

$$
\text{MSE}\left[\hat{\theta}\right] \triangleq
\mathbb{E}\left[\left(\hat{\theta} - \theta\right)^2\right] =
\left(\text{bias}\left[\hat{\theta}\right]\right)^2 + 
\text{var}\left[\hat{\theta}\right]
$$

### Example

Consider $X_1, X_2, X_3 \sim N(\mu, \sigma^2)$.

Define two estimators for the true mean, $\mu$.

$$
\bar{X} = \frac{1}{n}\sum_{i = 1}^{3} X_i
$$

$$
\hat{\mu} = \frac{1}{4}X_1 + \frac{1}{5}X_2 + \frac{1}{6}X_3
$$

- Calculate and compare the mean square error of both $\bar{X}$ and $\hat{\mu}$ as estimators of $\mu$.

First, recall from properties of the sample mean that

$$
\text{E}\left[\bar{X}\right] = \mu
$$

and

$$
\text{var}\left[\bar{X}\right] = \frac{\sigma^2}{3}
$$

Thus we have

$$
\text{bias}\left[\bar{X}\right] = 
\mathbb{E}\left[\bar{X}\right] - \mu = 
\mu - \mu = 0
$$

Then, 

$$
\text{MSE}\left[\bar{X}\right] \triangleq
\left(\text{bias}\left[\bar{X}\right]\right)^2 +
\text{var}\left[\bar{X}\right] =
0 + \frac{\sigma^2}{3} = 
\frac{\sigma^2}{3}
$$

Next,

$$
\text{E}\left[\hat{\mu}\right] = \frac{\mu}{4} + \frac{\mu}{5} + \frac{\mu}{6} = \frac{37}{60}\mu
$$

and

$$
\text{var}\left[\hat{\mu}\right] = \frac{\sigma^2}{16} + \frac{\sigma^2}{25} + \frac{\sigma^2}{36} = \frac{469}{3600}\sigma^2
$$

Now we have

$$
\text{bias}\left[\hat{\mu}\right] = 
\mathbb{E}\left[\hat{\mu}\right] - \mu = 
\frac{37}{60}\mu - \mu = \frac{-23}{60}\mu
$$

Then finally we obtain the mean squared error for $\hat{\mu}$, 

$$
\text{MSE}\left[\hat{\mu}\right] \triangleq
\left(\text{bias}\left[\hat{\mu}\right]\right)^2 +
\text{var}\left[\hat{\mu}\right] =
\left( \frac{-23}{60}\mu \right)^2 +
\frac{469}{3600}\sigma^2
$$

Note that $\text{MSE}\left[\hat{\mu}\right]$ is small when $\mu$ is close to 0.

<!-- #### Consistency -->

<!-- An estimator $\hat{\theta}_n$ is said to be a **consistent estimator** of $\theta$ if, for any positive $\epsilon$, -->

<!-- $$ -->
<!-- \lim_{n \rightarrow \infty} P\left( \left| \hat{\theta}_n - \theta \right| \leq  \epsilon\right) =1 -->
<!-- $$ -->

<!-- or, equivalently, -->

<!-- $$ -->
<!-- \lim_{n \rightarrow \infty} P\left( \left| \hat{\theta}_n - \theta \right| >  \epsilon\right) =0 -->
<!-- $$ -->

<!-- We say that $\hat{\theta}_n$ **converges in probability** to $\theta$ and we write $\hat{\theta}_n \overset P \rightarrow \theta$. -->

<!-- ### Methods -->

<!-- - TODO: MLE -->

<!-- Given a random sample $X_1, X_2, \ldots, X_n$ from a population with parameter $\theta$ and density or mass $f(x \mid \theta)$, we have: -->

<!-- The Likelihood, $L(\theta)$, -->

<!-- $$ -->
<!-- L(\theta) = f(x_1, x_2, \ldots, x_n) = \prod_{i = 1}^{n} f(x_i \mid \theta) -->
<!-- $$ -->

<!-- The **Maximum Likelihood Estimator**, $\hat{\theta}$ -->

<!-- $$ -->
<!-- \hat{\theta} =  \underset{\theta}{\text{argmax}} \ L(\theta) = \underset{\theta}{\text{argmax}} \ \log L(\theta) -->
<!-- $$ -->


<!-- - TODO: Invariance Principle -->

<!-- If $\hat{\theta}$ is the MLE of $\theta$ and the function $h(\theta)$ is continuous, then $h(\hat{\theta})$ is the MLE of $h(\theta)$. -->

<!-- - TODO: MOM -->

<!-- - TODO: https://daviddalpiaz.github.io/stat3202-sp19/notes/fitting.html -->

<!-- - TODO: ECDF: https://en.wikipedia.org/wiki/Empirical_distribution_function -->

***

## Source

- `R` Markdown: [`04-statistics.Rmd`](04-statistics.Rmd)

***
