answers_from <- function(...) {
  queue <- c(...)
  function(prompt) {
    answer <- queue[1]
    queue <<- queue[-1]
    answer
  }
}

test_that("play_roulette() needs an interactive session", {
  expect_error(play_roulette(), "interaktive")
})

test_that("each round records the model and whether the answer was right", {
  set.seed(6)
  played <- NULL
  capture.output(
    played <- run_roulette(
      3,
      n_items = 3:6,
      n = NULL,
      read = answers_from("a", "b", "c")
    )
  )
  expect_equal(nrow(played), 3)
  expect_equal(played$answer, c("a", "b", "c"))
  expect_equal(
    played$correct,
    played$answer == names(model_letters)[match(played$model, model_letters)]
  )
})

test_that("invalid input is asked again and q ends the game", {
  set.seed(7)
  played <- NULL
  output <- capture.output(
    played <- run_roulette(
      5,
      n_items = 3,
      n = NULL,
      read = answers_from("x", "A", "q")
    )
  )
  expect_true(any(grepl("Bitte tippen Sie", output)))
  expect_equal(nrow(played), 1)
  expect_equal(played$answer, "a")
})

test_that("n_items outside 3 to 6 stops the game", {
  expect_error(
    run_roulette(1, n_items = 2:3, n = NULL, read = answers_from("a")),
    "3 bis 6"
  )
})
