test_that("test_anxiety has two samples and 20 items on a 1-7 scale", {
  expect_equal(dim(test_anxiety), c(2000L, 21L))
  expect_named(test_anxiety, c("sample", sprintf("i%02d", 1:20)))
  expect_equal(
    as.vector(table(test_anxiety$sample)),
    c(1000L, 1000L)
  )
  items <- unlist(test_anxiety[-1])
  expect_true(all(items %in% 1:7))
})

test_that("test_anxiety matches the values in the workbook", {
  online <- test_anxiety[test_anxiety$sample == "online", -1]
  students <- test_anxiety[test_anxiety$sample == "students", -1]
  expect_equal(round(sd(rowSums(online)), 2), 17.84)
  expect_equal(round(sd(rowSums(students)), 2), 11.25)
})
