
x <- -100000:100000

# Added NA to make sure that it won't fail
set.seed(123)
x[sample(length(x), size = length(x) * 0.01)] <- NA
df <- data.frame(x = x)
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
df$eth_new_d <- suppressWarnings(eth_make_date(df$eth_y, df$eth_m, df$eth_d1))

df$eth_as_date <- as.Date(df$eth_d)
df$eth_from_gre <- eth_date(df$gre_d)
df$posix_1 <- as.POSIXct(df$gre_d)
df$posix_2 <- as.POSIXlt(df$gre_d)
df$eth_from_1 <- eth_date(df$posix_1)
df$eth_from_2 <- eth_date(df$posix_2)

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
  expect_equal(sum(df$eth_leap, na.rm = T), 49651)
})

test_that("Ethiopia has more leap years", {
  expect_gt(sum(df$eth_leap, na.rm = T), sum(df$gre_leap, na.rm = T))
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

test_that("eth_date_validate warnings", {
  expect_warning(eth_date_validate(2015, NA, NA))
  expect_warning(eth_date_validate(2015, 01, 40))
  expect_warning(eth_date_validate(2015, 15, 01))
  expect_warning(eth_date_validate(2012, 13, 06))
  expect_warning(eth_date_validate(2011, 13, 08))
})

test_that("Origin", {
  expect_equal(eth_date(0, origin = eth_today()), eth_today())
  expect_error(eth_date(0, origin = c(0, 2)))
  expect_error(suppressWarnings(eth_date(0, origin = "ff")))
})


test_that("eth_parse_date errors", {
  expect_error(eth_parse_date("2017-01-01", format = c("%Y-%m-%d", "%Y-%m-%d")))
  expect_error(eth_parse_date(0, format = "%Y-%m-%d"))
  expect_error(eth_parse_date("2017-01-01", format = "%Y-%d"))
  expect_error(eth_parse_date("2017-01-01", format = "%m-%m-%d"))
  expect_error(eth_parse_date("2017-01-01", format = "%Y-%d-%d"))
  expect_error(eth_parse_date("2017-01-01", format = "%Y-%m-%m"))
})

test_that("eth_parse_date", {
  expect_equal(eth_parse_date("20tah17", format = "%d%b%y"), eth_date("2017-04-20"))
  expect_equal(eth_parse_date("20tahsas17", format = "%d%B%y"), eth_date("2017-04-20"))
  expect_equal(eth_parse_date("20ታህ17", format = "%d%b%y", lang = "amh"), eth_date("2017-04-20"))
  expect_equal(eth_parse_date("20ታህሳስ17", format = "%d%B%y", lang = "amh"), eth_date("2017-04-20"))
  expect_equal(eth_parse_date("20dec17", format = "%d%b%y", lang = "en"), eth_date("2017-04-20"))
  expect_equal(eth_parse_date("20December17", format = "%d%B%y", lang = "en"), eth_date("2017-04-20"))
})

test_that("default", {
  expect_equal(eth_date.default(0), eth_date(0))
})


test_that("factor", {
  expect_equal(eth_date(factor("2017-01-01")), eth_date("2017-01-01"))
})


test_that("factor", {
  qs <- c("Q1", "Q2", "Q3", "Q4", NA)
  dt <- suppressWarnings(eth_date(c("2017-01-01", "2017-04-15", "2017-08-29", "2017-13-05", NA)))
  expect_equal(eth_quarter(dt), qs)
})





