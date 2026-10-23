all_equal <- function(x) diff(range(x)) < 1e-9
all_distinct <- function(x) !anyDuplicated(round(x, 2))
off_diagonal <- function(m) m[lower.tri(m)]

test_that("each model shows its pattern in the exact moments", {
  set.seed(1)
  for (i in 1:20) {
    parallel <- simulate_model("parallel", n_items = 4)
    expect_true(all_equal(parallel$means))
    expect_true(all_equal(diag(parallel$cov)))
    expect_true(all_equal(off_diagonal(parallel$cov)))

    essentially_parallel <- simulate_model("essentially_parallel", n_items = 4)
    expect_true(all_distinct(essentially_parallel$means))
    expect_true(all_equal(diag(essentially_parallel$cov)))
    expect_true(all_equal(off_diagonal(essentially_parallel$cov)))

    tau_equivalent <- simulate_model("tau_equivalent", n_items = 4)
    expect_true(all_equal(tau_equivalent$means))
    expect_true(all_distinct(diag(tau_equivalent$cov)))
    expect_true(all_equal(off_diagonal(tau_equivalent$cov)))

    essentially_tau <- simulate_model("essentially_tau_equivalent", n_items = 4)
    expect_true(all_distinct(essentially_tau$means))
    expect_true(all_distinct(diag(essentially_tau$cov)))
    expect_true(all_equal(off_diagonal(essentially_tau$cov)))

    congeneric <- simulate_model("tau_congeneric", n_items = 4)
    expect_true(all_distinct(congeneric$means))
    expect_false(all_equal(off_diagonal(congeneric$cov)))
  }
})

test_that("tau-congeneric covariances come from one factor", {
  set.seed(2)
  for (i in 1:20) {
    s <- simulate_model("tau_congeneric", n_items = 4)$cov
    # one factor implies equal products of opposite covariance pairs
    expect_equal(s[1, 2] * s[3, 4], s[1, 3] * s[2, 4])
    expect_equal(s[1, 2] * s[3, 4], s[1, 4] * s[2, 3])
  }
})

test_that("moments are valid and have two decimals", {
  set.seed(3)
  for (size in 3:6) {
    for (model in models) {
      x <- simulate_model(model, n_items = size)
      expect_length(x$means, size)
      expect_equal(dim(x$cov), c(size, size))
      expect_true(isSymmetric(x$cov))
      expect_no_error(chol(x$cov))
      expect_equal(x$cov, round(x$cov, 2))
      expect_equal(x$means, round(x$means, 2))
    }
  }
})

test_that("a sample comes with data of size n", {
  set.seed(4)
  x <- simulate_model("parallel", n_items = 3, n = 500)
  expect_equal(dim(x$data), c(500L, 3L))
  expect_equal(x$means, colMeans(x$data))
})

test_that("invalid arguments stop with a message", {
  expect_error(simulate_model("unknown"))
  expect_error(simulate_model("parallel", n_items = 7), "3 bis 6")
  expect_error(simulate_model("parallel", n = 5), "ab 10")
})

test_that("the table shows means and the lower triangle", {
  set.seed(5)
  table <- as.data.frame(simulate_model("parallel", n_items = 3))
  expect_equal(rownames(table), c("Mittelwert", "x1", "x2", "x3"))
  expect_equal(table["x1", "x2"], "")
  expect_match(table["x2", "x1"], "^\\d\\.\\d{2}$")
})
