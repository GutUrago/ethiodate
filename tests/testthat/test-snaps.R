
# Summary -----

test_that("Summary works for NAs too", {
  expect_snapshot(summary(eth_date(0:10)))
  expect_snapshot(summary(eth_date(c(NA, 0:10, NA))))
})



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

# Month and weekday names ----

test_that("Month names", {
  x <- eth_date(0)
  expect_equal(eth_monthname(x), "ታህሳስ")
  expect_equal(eth_monthname(x, abbreviate = T), "ታህ")
  expect_equal(eth_monthname(x, "lat"), "Tahsas")
  expect_equal(eth_monthname(x, "lat", abbreviate = T), "Tah")
  expect_equal(eth_monthname(x, "en"), "December")
  expect_equal(eth_monthname(x, "en", abbreviate = T), "Dec")
})


test_that("Weekday names", {
  x <- eth_date(0)
  expect_equal(eth_weekday(x), "ሐሙስ")
  expect_equal(eth_weekday(x, abbreviate = T), "ሐሙ")
  expect_equal(eth_weekday(x, "lat"), "Hamus")
  expect_equal(eth_weekday(x, "lat", abbreviate = T), "Ham")
  expect_equal(eth_weekday(x, "en"), "Thursday")
  expect_equal(eth_weekday(x, "en", abbreviate = T), "Thu")
})



