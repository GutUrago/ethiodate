
# Date ----

test_that("new_ethdate constructor works", {
  x <- new_ethdate(1:3)
  expect_s3_class(x, "ethdate")
  expect_equal(vctrs::vec_data(x), 1:3)

  y <- new_ethdate(x)
  expect_identical(x, y)

  z <- new_ethdate(c(1, 2.0, 3))
  expect_s3_class(z, "ethdate")
  expect_equal(vctrs::vec_data(z), c(1L, 2L, 3L))

  expect_error(new_ethdate("a"), "`x` must be an integer vector.")
})

test_that("vec_ptype2.ethdate.* works as expected", {
  e <- new_ethdate(1:3)

  expect_s3_class(vctrs::vec_ptype2(e, e), "ethdate")
  expect_type(vctrs::vec_ptype2(e, 1.0), "double")
  expect_type(vctrs::vec_ptype2(1.0, e), "double")
  expect_type(vctrs::vec_ptype2(e, 1L), "integer")
  expect_type(vctrs::vec_ptype2(1L, e), "integer")
  expect_type(vctrs::vec_ptype2(e, "a"), "character")
  expect_type(vctrs::vec_ptype2("a", e), "character")

  result1 <- vctrs::vec_ptype2(e, TRUE)
  result2 <- vctrs::vec_ptype2(TRUE, e)
  expect_s3_class(result1, "ethdate")
  expect_s3_class(result2, "ethdate")
  expect_equal(vctrs::vec_data(result1), integer())
  expect_equal(vctrs::vec_data(result2), integer())
})

test_that("vec_cast.ethdate.* works as expected", {
  e <- new_ethdate(1:3)

  expect_s3_class(vctrs::vec_cast(1:3, to = e), "ethdate")
  expect_identical(vctrs::vec_cast(e, to = integer()), 1:3)

  expect_s3_class(vctrs::vec_cast(1.0, to = e), "ethdate")
  expect_identical(vctrs::vec_cast(e, to = double()), as.double(1:3))

  expect_s3_class(vctrs::vec_cast("2017-01-01", to = e), "ethdate")
  expect_type(vctrs::vec_cast(e, to = character()), "character")

  expect_s3_class(vctrs::vec_cast(TRUE, to = e), "ethdate")
  expect_equal(vctrs::vec_data(vctrs::vec_cast(TRUE, to = e)), NA_integer_)
  expect_equal(vctrs::vec_cast(e, to = logical()), 1:3)
})

test_that("vec_proxy_compare.ethdate returns integer vector", {
  e <- new_ethdate(1:3)
  expect_equal(vctrs::vec_proxy_compare(e), 1:3)
})

test_that("vec_restore.ethdate restores ethdate object", {
  x <- c(1L, 2L, 3L)
  restored <- vctrs::vec_restore(x, new_ethdate())
  expect_s3_class(restored, "ethdate")
  expect_equal(vctrs::vec_data(restored), x)
})




# Difftime ----

test_that("new_ethdifftime constructor works", {
  x <- new_ethdifftime(1:3)
  expect_s3_class(x, "ethdifftime")
  expect_equal(vctrs::vec_data(x), 1:3)
  expect_equal(attr(x, "units"), "days")

  x2 <- new_ethdifftime(c(1, 2.5, 3))
  expect_equal(vctrs::vec_data(x2), c(1L, 2L, 3L))

  expect_error(new_ethdifftime("a"), "`x` must be an integer vector.")
})

test_that("vec_ptype2.ethdifftime.* works as expected", {
  e <- new_ethdifftime(1:3)

  expect_s3_class(vctrs::vec_ptype2(e, e), "ethdifftime")
  expect_type(vctrs::vec_ptype2(e, 1.0), "double")
  expect_type(vctrs::vec_ptype2(1.0, e), "double")
  expect_type(vctrs::vec_ptype2(e, 1L), "integer")
  expect_type(vctrs::vec_ptype2(1L, e), "integer")
  expect_type(vctrs::vec_ptype2(e, "a"), "character")
  expect_type(vctrs::vec_ptype2("a", e), "character")

  result1 <- vctrs::vec_ptype2(e, TRUE)
  result2 <- vctrs::vec_ptype2(TRUE, e)
  expect_s3_class(result1, "ethdifftime")
  expect_s3_class(result2, "ethdifftime")
  expect_equal(vctrs::vec_data(result1), integer())
  expect_equal(vctrs::vec_data(result2), integer())
})

test_that("vec_cast.ethdifftime.* works as expected", {
  e <- new_ethdifftime(1:3)

  expect_s3_class(vctrs::vec_cast(1:3, to = e), "ethdifftime")
  expect_identical(vctrs::vec_cast(e, to = integer()), 1:3)

  expect_s3_class(vctrs::vec_cast(1.0, to = e), "ethdifftime")
  expect_equal(vctrs::vec_cast(e, to = double()), as.numeric(1:3))

  expect_s3_class(vctrs::vec_cast(c("1", "2", "3"), to = e), "ethdifftime")
  expect_equal(
    vctrs::vec_cast(e, to = character()),
    as.character(1:3)
  )
})

test_that("vec_proxy_compare.ethdifftime returns difftime object", {
  e <- new_ethdifftime(1:3)
  proxy <- vctrs::vec_proxy_compare(e)
  expect_s3_class(proxy, "difftime")
  expect_equal(as.numeric(proxy), 1:3)
  expect_equal(attr(proxy, "units"), "days")
})

test_that("vec_restore.ethdifftime restores correctly", {
  x <- 1:3
  restored <- vctrs::vec_restore(x, new_ethdifftime())
  expect_s3_class(restored, "ethdifftime")
  expect_equal(vctrs::vec_data(restored), x)
  expect_equal(attr(restored, "units"), "days")
})
