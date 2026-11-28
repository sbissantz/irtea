# Answers of psychology freshmen at the University of Amsterdam to Raven's
# Advanced Progressive Matrices, from the data published with Wicherts and
# Bakker (2012), Intelligence, 40(2), 73-76, doi:10.1016/j.intell.2012.01.004.
# The authors write: "The data are anonymized and may be used for any purpose.
# Our only request is a proper citation to this editorial."
#
# The original file has 537 rows. 16 rows have no answers to the Raven items
# at all and are dropped; the remaining 521 rows have no missing values in
# rav1 to rav33. Items rav34 to rav36 and all other variables are left out.

items <- paste0("rav", 1:33)

original <- foreign::read.spss(
  "data-raw/wicherts-bakker-2012.sav",
  to.data.frame = TRUE
)
answers <- original[items]

answered_any <- rowSums(!is.na(answers)) > 0
answers <- answers[answered_any, ]
stopifnot(nrow(answers) == 521, !anyNA(answers))

raven <- data.frame(lapply(answers, as.integer))
stopifnot(all(unlist(raven) %in% 0:1))

usethis::use_data(raven, overwrite = TRUE)
