test_that("raven has 521 complete rows of 33 dichotomous items", {
  expect_s3_class(raven, "data.frame")
  expect_equal(dim(raven), c(521L, 33L))
  expect_named(raven, paste0("rav", 1:33))
  expect_true(all(vapply(raven, is.integer, logical(1))))
  expect_true(all(unlist(raven) %in% 0:1))
})
