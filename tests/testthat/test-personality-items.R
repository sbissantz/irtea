test_that("personality_items has 7 persons and 3 numeric items", {
  expect_equal(dim(personality_items), c(7L, 3L))
  expect_named(personality_items, c("i1", "i2", "i3"))
  expect_true(all(vapply(personality_items, is.numeric, logical(1))))
})

test_that("personality_items matches the item means in the workbook", {
  expect_equal(
    round(colMeans(personality_items), 2),
    c(i1 = 7.39, i2 = 5.63, i3 = -2.80)
  )
})
