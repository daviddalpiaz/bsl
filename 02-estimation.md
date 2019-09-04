# Estimation

- TODO: Where we are going, estimating conditional means and distributions.
- TODO: estimation = learning. "learning from data." what are we learning about? often parameters.
- TODO: <https://stat400.org>
- TODO: <https://stat420.org>

## Probability

- TODO: See Appendix A
- TODO: In R, `d*()`, `p*()`, `q*()`, `r*()`

## Statistics

- TODO: parameters are a function of the population distribution
- TODO: statistics are a function of data.
- TODO: parameters:population::statistics::data
- TODO: statistic vs value of a statistic

## Estimators

- TODO: estimator vs estimate
- TODO: Why such a foucs on the mean, E[X]? Because E[(X - a)^2] is minimized by E[X]
    - <https://www.benkuhn.net/squared>
    - <https://news.ycombinator.com/item?id=9556459>

### Properties

#### Bias

$$
\text{bias}\left[\hat{\theta}\right] \triangleq 
\mathbb{E}\left[\hat{\theta}\right] - \theta
$$

#### Variance

$$
\text{var}\left[\hat{\theta}\right] \triangleq 
\mathbb{E}\left[ \left( \hat{\theta} -\mathbb{E}\left[\hat{\theta}\right] \right)^2 \right]
$$

#### Mean Squared Error

$$
\text{MSE}\left[\hat{\theta}\right] \triangleq  
\mathbb{E}\left[\left(\hat{\theta} - \theta\right)^2\right] = 
\text{var}\left[\hat{\theta}\right] + 
\left(\text{Bias}\left[\hat{\theta}\right]\right)^2
$$

#### Consistency

An estimator $\hat{\theta}_n$ is said to be a **consistent estimator** of $\theta$ if, for any positive $\epsilon$, 

$$
\lim_{n \rightarrow \infty} P\left( \left| \hat{\theta}_n - \theta \right| \leq  \epsilon\right) =1
$$

or, equivalently,

$$
\lim_{n \rightarrow \infty} P\left( \left| \hat{\theta}_n - \theta \right| >  \epsilon\right) =0
$$

We say that $\hat{\theta}_n$ **converges in probability** to $\theta$ and we write $\hat{\theta}_n \overset P \rightarrow \theta$.

### Methods

- TODO: MLE

Given a random sample $X_1, X_2, \ldots, X_n$ from a population with parameter $\theta$ and density or mass $f(x \mid \theta)$, we have:

The Likelihood, $L(\theta)$,

$$
L(\theta) = f(x_1, x_2, \ldots, x_n) = \prod_{i = 1}^{n} f(x_i \mid \theta)
$$

The **Maximum Likelihood Estimator**, $\hat{\theta}$

$$
\hat{\theta} =  \underset{\theta}{\text{argmax}} \ L(\theta) = \underset{\theta}{\text{argmax}} \ \log L(\theta)
$$
 

- TODO: Invariance Principle

If $\hat{\theta}$ is the MLE of $\theta$ and the function $h(\theta)$ is continuous, then $h(\hat{\theta})$ is the MLE of $h(\theta)$.

- TODO: MOM

- TODO: https://daviddalpiaz.github.io/stat3202-sp19/notes/fitting.html

- TODO: ECDF
