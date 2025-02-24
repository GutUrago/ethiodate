
x <- 15000:30000
eth_date <- as_eth_date(x)
to_gre_date <- to_gregorian(eth_date)
eth_numeric <- to_numeric_cpp(eth_date)
gre_date <- as.Date(x)
to_eth_date <- to_ethiopian(gre_date)
gre_numeric <- as.numeric(gre_date)



test_that("Converts to gregorian", {
  expect_equal(to_gre_date, gre_date)
})

test_that("Converts to ethiopian", {
  expect_equal(to_eth_date, eth_date)
})

test_that("Both have numeric underhood", {
  expect_equal(eth_numeric, gre_numeric)
})


# Operators ----

eth_date <- as_eth_date(c("2000-01-01", "2011-13-06"))
add_7_eth <- eth_date + 7
add_999_eth <- eth_date + 999
subs_77_eth <- eth_date - 77
subs_4555_eth <- eth_date - 4555

gre_date <- as.Date(as_numeric(eth_date))
add_7_gre <- gre_date + 7
add_999_gre <- gre_date + 999
subs_77_gre <- gre_date - 77
subs_4555_gre <- gre_date - 4555

test_that("Adding 7", {
  expect_equal(as_numeric(add_7_eth), as.numeric(add_7_gre))
})

test_that("Adding 999", {
  expect_equal(as_numeric(add_999_eth), as.numeric(add_999_gre))
})

test_that("Substract 77", {
  expect_equal(as_numeric(subs_77_eth), as.numeric(subs_77_gre))
})

test_that("Substract 4555", {
  expect_equal(as_numeric(subs_4555_eth), as.numeric(subs_4555_gre))
})

test_that("Can substract dates", {
  expect_no_error(as_eth_date(10) - as_eth_date(5))
})

# Errors ----

test_that("Non objects are error", {
  expect_error(as_eth_date("19958"))
})


test_that("Non objects are error", {
  expect_error(to_ethiopian("19958"))
})

test_that("Cannot add string to dates", {
  expect_error(as_eth_date(10) + "5")
})

test_that("Cannot subtract string to dates", {
  expect_error(as_eth_date(10) + "5")
})

test_that("Printing", {
  dates <- as_eth_date(c(1:10))
  ints <- as_eth_date(11:20)
  diffs <- dates - ints
  expect_output(print(diffs, 5))
})

