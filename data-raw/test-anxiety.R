# Simulate answers to a fictitious 20-item test anxiety questionnaire (workbook
# chapter 8, EFA). Latent responses follow a factor model with four correlated
# factors; each item cuts its latent response into seven categories (1-7). The cut
# points come from item-specific category probabilities drawn from a Dirichlet
# distribution (induced Dirichlet; Betancourt, "Ordinal Modeling", section 5).
#
# Two samples of equal size share the measurement model (loadings, residuals,
# cut points): a heterogeneous online sample and a homogeneous student sample
# with a narrower spread on the factors.

# Factors: 1 Besorgtheit, 2 Aufgeregtheit, 3 Interferenz, 4 Mangel an Zuversicht.
# The questionnaire cycles through the factors: i01 -> 1, i02 -> 2, ..., i05 -> 1.
facet <- rep(1:4, times = 5)
main_loading <- c(
  0.75,
  0.70,
  0.70,
  0.70,
  0.70,
  0.65,
  0.65,
  0.65,
  0.65,
  0.60,
  0.45,
  0.70,
  0.70,
  0.70,
  0.70,
  0.60,
  0.60,
  0.65,
  0.60,
  0.30 # i20 is a weak item
)
lambda <- matrix(0, nrow = 20, ncol = 4)
lambda[cbind(1:20, facet)] <- main_loading
lambda[11, 1] <- 0.35 # i11 also loads on Besorgtheit

phi <- matrix(
  c(
    1.00,
    0.60,
    0.50,
    0.40,
    0.60,
    1.00,
    0.45,
    0.30,
    0.50,
    0.45,
    1.00,
    0.25,
    0.40,
    0.30,
    0.25,
    1.00
  ),
  nrow = 4
)

# Residual variances give each latent response variance 1 in the online sample.
# i07 and i13 share content (recalling what was learned), which the factors do not
# explain: a residual covariance.
communality <- diag(lambda %*% phi %*% t(lambda))
theta <- diag(1 - communality)
theta[7, 13] <- theta[13, 7] <- 0.25

# Baseline category probabilities; tau sets how much items vary around them.
rho <- c(0.10, 0.15, 0.18, 0.18, 0.17, 0.13, 0.09)
tau <- 0.02

draw_dirichlet <- function(alpha) {
  gamma_draw <- rgamma(length(alpha), alpha)
  gamma_draw / sum(gamma_draw)
}

simulate_sample <- function(n, factor_sd, cut_points) {
  factor_scores <- MASS::mvrnorm(n, rep(0, 4), factor_sd^2 * phi)
  residuals <- MASS::mvrnorm(n, rep(0, 20), theta)
  latent <- factor_scores %*% t(lambda) + residuals
  responses <- sapply(1:20, \(j) {
    findInterval(latent[, j], cut_points[j, ]) + 1L
  })
  colnames(responses) <- sprintf("i%02d", 1:20)
  as.data.frame(responses)
}

set.seed(11)
cut_points <- t(replicate(
  20,
  qnorm(cumsum(draw_dirichlet(rho / tau + 1))[1:6])
))
online <- simulate_sample(1000, factor_sd = 1, cut_points = cut_points)
students <- simulate_sample(1000, factor_sd = 0.5, cut_points = cut_points)

test_anxiety <- rbind(
  data.frame(sample = "online", online),
  data.frame(sample = "students", students)
)

usethis::use_data(test_anxiety, overwrite = TRUE)
