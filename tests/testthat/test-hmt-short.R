test_that("hmt_short has two devices and six dichotomous items", {
  expect_equal(dim(hmt_short), c(800L, 7L))
  expect_named(hmt_short, c("device", paste0("hmt", 1:6)))
  expect_equal(
    as.vector(table(hmt_short$device)),
    c(400L, 400L)
  )
  expect_true(all(unlist(hmt_short[-1]) %in% 0:1))
})

test_that("hmt_short matches the solution rates in the workbook", {
  expect_equal(
    round(colMeans(hmt_short[-1]), 2),
    c(hmt1 = 0.86, hmt2 = 0.69, hmt3 = 0.55, hmt4 = 0.44, hmt5 = 0.27, hmt6 = 0.20)
  )
})
