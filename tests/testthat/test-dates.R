
# Data setup for tests ----
library(dplyr, quietly = TRUE)

set.seed(123)

df <- tibble(x = -100000:100000) |>
  mutate(
    .row = row_number(),
    bad = .row %in% sample.int(n(), size = floor(0.04 * n())),
    x = if_else(
      bad,
      sample(c(NA_real_, NaN, Inf, -Inf), n(), replace = TRUE),
      x
    )
  ) |>
  select(x) |>
  mutate(
    # Gregorian / Ethiopian base
    gre_d = as.Date(x),
    eth_d = eth_date(x),

    gre_x = as.numeric(gre_d),
    eth_x = as.numeric(eth_d),

    # Date arithmetic
    gre_add_7 = gre_d + 7,
    gre_sub_7 = gre_d - 7,
    eth_add_7 = eth_d + 7,
    eth_sub_7 = eth_d - 7,

    # Leap years
    eth_leap = is_eth_leap(eth_d),

    gre_year = as.POSIXlt(gre_d)$year + 1900,
    gre_leap = gre_year %% 4 == 0 &
      (gre_year %% 100 != 0 | gre_year %% 400 == 0),

    # Ethiopian components
    eth_y = eth_year(eth_d),
    eth_m = eth_month(eth_d),
    eth_d1 = eth_day(eth_d),

    eth_new_d = suppressWarnings(eth_make_date(eth_y, eth_m, eth_d1)),

    # Coercions
    eth_as_date = as.Date(eth_d),
    eth_from_gre = eth_date(gre_d),

    posix_1 = as.POSIXct(gre_d),
    posix_2 = as.POSIXlt(gre_d),

    eth_from_1 = eth_date(posix_1),
    eth_from_2 = eth_date(posix_2)
  ) %>%
  select(-gre_year)





# Test start here ----

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
  expect_equal(sum(df$eth_leap, na.rm = T), 48130)
})

test_that("Ethiopia has more leap years", {
  expect_gt(sum(df$eth_leap, na.rm = T), sum(df$gre_leap, na.rm = T))
})

# test_that("Extract components and make date again", {
#   expect_equal(df$eth_d, df$eth_new_d)
# })

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

test_that("Constructors coerce to double", {
  expect_no_error(new_ethdate("0"))
  expect_no_error(new_ethdifftime("0"))
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
      td = NA_real_,
      wx = NA_integer_
    )
  )
  expect_equal(eth_date_components(NA), x)
})

test_that("eth_date_validate no warnings", {
  expect_no_warning(eth_date_validate(2015, NA, NA))
  expect_no_warning(eth_date_validate(2015, 01, 40))
  expect_no_warning(eth_date_validate(2015, 15, 01))
  expect_no_warning(eth_date_validate(2012, 13, 06))
  expect_no_warning(eth_date_validate(2011, 13, 08))
})

test_that("Origin", {
  expect_equal(eth_date(0, origin = eth_today()), eth_today())
  expect_no_error(eth_date(0, origin = c(0, 2)))
  expect_no_error(eth_date(0, origin = "ff"))
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

test_that("All should be parsed with their methods", {
  expect_error(eth_date.default(0))
})


test_that("factor", {
  expect_equal(eth_date(factor("2017-01-01")), eth_date("2017-01-01"))
})


test_that("factor", {
  qs <- c("Q1", "Q2", "Q3", "Q4", NA)
  dt <- suppressWarnings(eth_date(c("2017-01-01", "2017-04-15", "2017-08-29", "2017-13-05", NA)))
  expect_equal(eth_quarter(dt), qs)
})

test_that("NULL and NA", {
  expect_no_error(eth_date(0))
  expect_no_error(eth_date.default(NULL))
  expect_no_error(eth_date.default(NA))
  expect_error(eth_date.default(TRUE))
  expect_equal(eth_monthname(4), "Tahsas")
  expect_no_error(as.integer(eth_date(0)))
})



