test_that("Basic parsing", {
  expect_no_error(eth_date("1959-01-01"))
  expect_equal(eth_date("1962-4-23"), eth_date(0))
  expect_equal(eth_date("1962-Tahsas-23", format = "%Y-%B-%d", lang = "lat"), eth_date(0))
})


test_that("Counts invalid dates", {
  x <- c("2017-08-77", "2017-01-01", "2017-78-5")
  expect_snapshot(eth_date(x))
})
