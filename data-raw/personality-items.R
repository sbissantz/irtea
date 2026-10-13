# build the dataset from the table in workbook chapter 1, exercise 3
personality_items <- data.frame(
  i1 = c(7.68, 7.40, 7.28, 6.80, 7.38, 7.48, 7.72),
  i2 = c(1.16, 4.42, 7.39, 11.89, 2.31, 5.87, 6.34),
  i3 = c(-3.58, -2.69, -2.00, -0.32, -3.30, -2.95, -4.74)
)

usethis::use_data(personality_items, overwrite = TRUE)
