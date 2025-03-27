df <- data.frame(x = -100000:100000)

df$gre_d <- as.Date(df$x)
df$eth_d <- eth_date(df$x)
df$gre_x <- as.numeric(df$gre_d)
df$eth_x <- as.numeric(df$eth_d)
df$gre_add_7 <- df$gre_d + 7
df$gre_sub_7 <- df$gre_d - 7
df$eth_add_7 <- df$eth_d + 7
df$eth_sub_7 <- df$eth_d - 7
df$eth_leap <- is_eth_leap(df$eth_d)
df$gre_leap <- as.numeric(format(df$gre_d, "%Y")) %% 4 == 0 & (as.numeric(format(df$gre_d, "%Y")) %% 100 != 0 | as.numeric(format(df$gre_d, "%Y")) %% 400 == 0)

df$eth_y <- eth_year(df$eth_d)
df$eth_m <- eth_month(df$eth_d)
df$eth_d1 <- eth_day(df$eth_d)
df$eth_new_d <- eth_make_date(df$eth_y, df$eth_m, df$eth_d1)

df$eth_as_date <- as.Date(df$eth_d)
df$eth_from_gre <- eth_date(df$gre_d)
df$posix_1 <- as.POSIXct(df$gre_d)
df$posix_2 <- as.POSIXlt(df$gre_d)
df$eth_from_1 <- eth_date(df$posix_1)
df$eth_from_2 <- eth_date(df$posix_2)

# weird format for testing purpose
# df$eth_char <- as.character(df$eth_from_1, format = "%Y - %d -%m")
# df$eth_prs <- eth_date(df$eth_char, format = "%Y - %d -%m")


test_that("Internally stored values are the same as base Date", {
  expect_equal(df$gre_x, df$eth_x)
})

test_that("Additions works", {
  expect_equal(unclass(df$gre_add_7), unclass(df$eth_add_7))
})

test_that("Subtraction works", {
  expect_equal(unclass(df$gre_sub_7), unclass(df$eth_sub_7))
})

test_that("Leap years", {
  expect_equal(sum(df$eth_leap), 50142)
})

test_that("Ethiopia has more leap years", {
  expect_gt(sum(df$eth_leap), sum(df$gre_leap))
})

test_that("Extract components and make date again", {
  expect_equal(df$eth_d, df$eth_new_d)
})

test_that("Conversion to date", {
  expect_equal(df$eth_as_date, df$gre_d)
})

test_that("Conversion from date", {
  expect_equal(df$eth_d, df$eth_from_gre)
})

test_that("Conversion from POSIXct", {
  expect_equal(df$eth_d, df$eth_from_1)
})

test_that("Conversion from POSIXlt", {
  expect_equal(df$eth_d, df$eth_from_2)
})

test_that("Can be coerced to character", {
  expect_no_error(as.character(df$eth_d[1:10]))
})

test_that("new_ethDate accept only numeric", {
  expect_error(new_ethdate("0"))
  expect_error(new_ethdiffday("0"))
})

test_that("2011 is leap year", {
  expect_true(is_eth_leap(2011))
})

test_that("NA for NAs", {
  expect_equal(is_eth_leap(eth_date(c(NA, 0))), c(NA, FALSE))
})


test_that("Week_index", {
  x <- c(NA, 1,  2,  3,  4,  5,  6,  7,  1,  2,  3,  4,  5,  6,  7,  1,  2,  3,  4,  5,  6, 7)
  expect_equal(weekday_index(c(NA, -10:10)), x)
})

test_that("NA components are NA", {
  x <- list(
    list(
      year = NA_integer_,
      month = NA_integer_,
      day = NA_integer_,
      td = NA_integer_,
      wx = NA_integer_
    )
  )
  expect_equal(eth_date_components(NA), x)
})

test_that("eth_date_validate", {
  expect_true(is.na(eth_date_validate(2015, NA, NA)))
  expect_warning(eth_date_validate(2015, 01, 40))
  expect_warning(eth_date_validate(2015, 15, 01))
  expect_warning(eth_date_validate(2012, 13, 06))
  expect_warning(eth_date_validate(2011, 13, 08))
})
