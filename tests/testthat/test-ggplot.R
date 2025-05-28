

test_that("Scales", {
  date_scale <- ggplot2::scale_type(new_ethdate())
  difftime_scale <- ggplot2::scale_type(new_ethdifftime())
  expect_equal(date_scale, c("ethdate", "continuous"))
  expect_equal(difftime_scale, "continuous")
  expect_no_error(scales::rescale(eth_date(0:10)))
})


test_that("No error with ggplot", {
  cpieth[["eth"]] <- eth_date(cpieth$date)
  expect_no_error(
      ggplot2::ggplot(cpieth, ggplot2::aes(eth, cpi)) +
    ggplot2::geom_line() +
    scale_x_ethdate(breaks = eth_breaks(5), labels = eth_labels("%Y"),
                    name = "Ethiopian year")
  )
  expect_no_error(
    ggplot2::ggplot(cpieth, ggplot2::aes(cpi, eth)) +
      ggplot2::geom_line() +
      scale_y_ethdate(breaks = eth_breaks(5, FALSE), labels = eth_labels("%Y"),
                      name = "Ethiopian year")
  )
})






test_that("eth_breaks() returns expected breaks (pretty = TRUE)", {
  x <- eth_date(c("2015-01-01", "2017-01-01"))

  breaks_fun <- eth_breaks(n = 4, pretty = TRUE)
  breaks <- breaks_fun(x)

  expect_s3_class(breaks, "ethdate")
  expect_true(length(breaks) >= 4)

  labels_fun <- eth_labels("%Y")
  expect_equal(labels_fun(x), c("2015", "2017"))

})

test_that("eth_breaks() returns expected breaks (pretty = FALSE)", {
  x <- eth_date(c("2015-01-01", "2017-01-01"))

  breaks_fun <- eth_breaks(n = 4, pretty = FALSE)
  breaks <- breaks_fun(x)

  expect_s3_class(breaks, "ethdate")
  expect_equal(length(breaks), 4)
  expect_true(all(vctrs::vec_data(breaks) >= min(vctrs::vec_data(x))))
  expect_true(all(vctrs::vec_data(breaks) <= max(vctrs::vec_data(x))))
})


