
# Summary -----

test_that("Summary works for NAs too", {
  expect_snapshot(summary(eth_date(0:10)))
  expect_no_error(summary(eth_date(c(NA, 0:10, NA))))
})



# Errors and warnings ----

test_that("eth_components works only on ethDate", {
  expect_snapshot(eth_year(0), error = TRUE)
  expect_snapshot(eth_month(0), error = TRUE)
  expect_snapshot(eth_monthname(0), error = TRUE)
  expect_snapshot(eth_weekday(0), error = TRUE)
  expect_snapshot(eth_day(0), error = TRUE)
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
  expect_equal(format(eth_date(c(1, NA))), c("1962-04-24", NA))
  expect_no_error(format(eth_date(0), c("%Y", "%y")))
  expect_snapshot(format(eth_date(2), format = 2), error = TRUE)
})



# Printing ----

test_that("Printing test", {
  expect_snapshot(print(eth_date(1:5)))
  expect_snapshot(print(eth_date(1:5) - eth_date(1)))
})

test_that("Printing test", {
  expect_snapshot(print(eth_date(1:5), max=3))
  expect_snapshot(print(eth_date(1:5) - eth_date(1)))
  expect_no_error(print(eth_date(NULL)))
})

# Month and weekday names ----

test_that("Month names", {
  x <- eth_date(0)
  expect_equal(eth_monthname(x), "Tahsas")
  expect_equal(eth_monthname(x, abbreviate = T), "Tah")
  expect_equal(eth_monthname(x, "amh"), "ታህሳስ")
  expect_equal(eth_monthname(x, "amh", abbreviate = T), "ታህ")
  expect_equal(eth_monthname(x, "en"), "December")
  expect_equal(eth_monthname(x, "en", abbreviate = T), "Dec")
})


test_that("Weekday names", {
  x <- eth_date(0)
  expect_equal(eth_weekday(x), "Hamus")
  expect_equal(eth_weekday(x, abbreviate = T), "Ham")
  expect_equal(eth_weekday(x, "amh"), "ሐሙስ")
  expect_equal(eth_weekday(x, "amh", abbreviate = T), "ሐሙ")
  expect_equal(eth_weekday(x, "en"), "Thursday")
  expect_equal(eth_weekday(x, "en", abbreviate = T), "Thu")
})


# Month and weekday names


for (x in c("%B", "%b", "%A", "%a")) {
  for (lang in c("amh", "lat", "en")) {
    test_name <- paste0("Format = ", x, "lang = ", lang)
    test_that(test_name, {
      expect_snapshot(eth_show(x, lang))
    })
  }
}

test_that("Error %C", {
  expect_error(eth_show("%C"))
})


# Components
test_that("Wrong component error", {
  expect_snapshot(get_component(2, "invalid"), error = TRUE)
  expect_snapshot(eth_make_date("2019", 2, 8), error = TRUE)
})

test_that("Print.ethdifftime", {
  expect_snapshot(new_ethdifftime(NULL))
  expect_snapshot(new_ethdifftime(1))
})


