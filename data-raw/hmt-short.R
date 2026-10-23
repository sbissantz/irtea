# Simulate answers to the six items of the short form of the Hagen Matrices
# Test (HMT-S) for workbook chapter 11 (item analysis with the Rasch model).
# The data are invented for teaching and say nothing about the real HMT-S.
#
# 800 people take the test online, 400 on a computer and 400 on a smartphone.
# Answers follow the Rasch model with the same ability distribution in both
# groups. Item hmt5 is harder on a smartphone (differential item functioning),
# so the Wald test and the graphical model check flag it.

difficulty <- c(-2.2, -1.0, -0.3, 0.3, 0.6, 1.6)
smartphone_shift <- c(0, 0, 0, 0, 1.2, 0)
n_per_device <- 400

simulate_rasch <- function(n, difficulty) {
  ability <- rnorm(n)
  probability <- plogis(outer(ability, difficulty, "-"))
  matrix(rbinom(length(probability), 1, probability), nrow = n)
}

# seed chosen so that only hmt5 shows misfit in the Wald test
set.seed(6)
computer <- simulate_rasch(n_per_device, difficulty)
smartphone <- simulate_rasch(n_per_device, difficulty + smartphone_shift)

answers <- rbind(computer, smartphone)
storage.mode(answers) <- "integer"
colnames(answers) <- paste0("hmt", 1:6)

hmt_short <- data.frame(
  device = rep(c("computer", "smartphone"), each = n_per_device),
  answers
)

usethis::use_data(hmt_short, overwrite = TRUE)
