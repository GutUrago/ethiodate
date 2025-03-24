

# Errors and warnings ----

test_that("eth_components works only on ethDate", {
  expect_snapshot(eth_year(0), error = TRUE)
  expect_snapshot(eth_month(0), error = TRUE)
  expect_snapshot(eth_monthname(0), error = TRUE)
  expect_snapshot(eth_weekday(0), error = TRUE)
  expect_snapshot(eth_day(0), error = TRUE)
})

test_that("eth_make works only for numeric and equal length vectors", {
  expect_snapshot(eth_make_date(1960:1970, 1:10, 10:20), error = TRUE)
  expect_snapshot(eth_make_date(1960:1970, 1:11, rep("x", 11)), error = TRUE)
})


test_that("Ops error testing", {
  expect_snapshot(eth_date(0) + eth_date(0), error = TRUE)
  expect_snapshot(1-eth_date(0), error = TRUE)

})


# Formatting ----

test_that("Formattig test", {
  expect_snapshot(format(
    eth_date(0),
    format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)"
  ))
  expect_snapshot(format(
    eth_date(0),
    format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)",
    lang = "lat"
  ))
  expect_snapshot(format(
    eth_date(0),
    format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)",
    lang = "en"
  ))
})



# Printing ----

test_that("Printing test", {
  expect_snapshot(eth_date(1:17))
  expect_snapshot(eth_date(1:17) - eth_date(1))
})
