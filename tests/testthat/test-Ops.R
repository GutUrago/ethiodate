

# Date -----

test_that("vec_arith.ethdate works as expected", {
  x <- eth_date(1:5)
  y <- eth_date(6:10)

  res <- x - y
  expect_s3_class(res, "ethdifftime")

  expect_equal(x + 1L, eth_date(2:6))
  expect_equal(x - 1L, eth_date(0:4))

  expect_equal(1L + x, eth_date(2:6))


  expect_error(vec_arith.numeric.ethdate("*", 2, eth_date(0)), "not permitted")
  expect_error(vec_arith.ethdate.numeric("/", eth_date(0), 2), "not permitted")
  expect_error(x * y, "not permitted")
  expect_error(x / 2, "not permitted")
})

test_that("vec_arith.ethdate and ethdifftime", {
  x <- eth_date(1:5)
  d <- new_ethdifftime(rep(1, 5))

  expect_equal(x + d, eth_date(2:6))
  expect_equal(x - d, eth_date(0:4))
  expect_no_error(d + d)
  expect_error(vec_arith.ethdate.ethdifftime("*", x, d))
})

test_that("vec_math.ethdate supports basic stats", {
  x <- eth_date(1:10)

  expect_equal(mean(x), eth_date(mean(1:10)))
  expect_equal(min(x), eth_date(1L))
  expect_equal(max(x), eth_date(10L))

  expect_equal(vec_math.ethdate("min", eth_date(0:10)), eth_date(0))
  expect_equal(vec_math.ethdate("max", eth_date(0:10)), eth_date(10))
  expect_error(vec_math.ethdate("quantile", eth_date(0:10)))

  expect_true(all(is.finite(x)))
  expect_false(any(is.infinite(x)))
  expect_false(any(is.nan(x)))
  expect_error(median(x), "not implemented")
})

test_that("summary.ethdate behaves correctly", {
  x <- eth_date(c(1:5, NA))
  out <- summary(x)
  expect_named(out, c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.", "NA's"))
  expect_type(out, "character")
  expect_no_error(summary(eth_date(0:10)))
})

test_that("seq.ethdate works for various cases", {
  f <- eth_date(1L)
  t <- eth_date(10L)

  expect_equal(seq(f, to = t, by = 1L), eth_date(1:10))
  expect_equal(seq(f, to = t, length.out = 10L), eth_date(1:10))
  expect_equal(seq(f, by = 1L, length.out = 10L), eth_date(1:10))

  expect_no_error(seq(f, t, along.with = 0:4))
  expect_error(seq(f, to = t), "Exactly two of")
  expect_error(seq(f, to = t, by = 1, length.out = 10), "Exactly two of")
  expect_error(seq(f, to = t, by = 1, length.out = 10, along.with=0:10), "only one")
})

test_that("cut.ethdate works with ethdate and numeric breaks", {
  x <- eth_date(1:10)

  brk1 <- eth_date(c(1, 5, 10))
  expect_type(cut(x, breaks = brk1), "integer")

  cut_n <- cut(x, breaks = 2)
  expect_type(cut_n, "integer")
  expect_equal(nlevels(cut_n), 2)

  expect_error(cut(x, breaks = "month"), "invalid specification")
  expect_error(cut.ethdate(0:10, 2))
})



# Difftime ----


test_that("vec_arith.ethdifftime works with ethdifftime", {
  x <- new_ethdifftime(1:5)
  y <- new_ethdifftime(6:10)

  expect_equal(vec_arith.ethdifftime("+", y, x),
               new_ethdifftime(c(7, 9, 11, 13, 15)))
  expect_equal(vec_arith.ethdifftime("-", y, x),
               new_ethdifftime(rep(5, 5)))
  expect_error(vec_arith.ethdifftime("/", y, x), "not permitted")
})

test_that("vec_arith.ethdifftime with numeric", {
  x <- new_ethdifftime(1:3)
  n <- 2

  expect_equal(vec_arith.ethdifftime("+", x, n), new_ethdifftime(3:5))
  expect_equal(vec_arith.ethdifftime("-", x, n), new_ethdifftime(-1:1))
  expect_equal(vec_arith.ethdifftime("*", x, n), new_ethdifftime(c(2, 4, 6)))
  expect_equal(vec_arith.ethdifftime("/", x, n), new_ethdifftime(c(0.5, 1, 1.5)))
  expect_error(vec_arith.ethdifftime("^", x, n), "not permitted")
})

test_that("vec_arith.numeric with ethdifftime", {
  x <- new_ethdifftime(1:3)
  n <- 2

  expect_equal(vec_arith.numeric("+", n, x), new_ethdifftime(3:5))
  expect_equal(vec_arith.numeric("-", n, x), new_ethdifftime(1:-1))
  expect_equal(vec_arith.numeric("*", n, x), new_ethdifftime(c(2, 4, 6)))
  expect_equal(vec_arith.numeric("/", n, x), new_ethdifftime(c(2, 1, 2/3)))
  expect_error(vec_arith.numeric("^", n, x), "not permitted")
})

test_that("vec_arith.ethdifftime with ethdate", {
  x <- new_ethdifftime(1:3)
  d <- eth_date(10:12)

  expect_equal(x + d, eth_date(c(11, 13, 15)))
  expect_error(x - d, "not permitted")
})

test_that("vec_math.ethdifftime supports standard math ops", {
  x <- new_ethdifftime(1:5)

  expect_equal(mean(x), new_ethdifftime(mean(1:5)))
  expect_equal(vec_math.ethdifftime("min", x), new_ethdifftime(min(1:5)))
  expect_equal(vec_math.ethdifftime("max", x), new_ethdifftime(max(1:5)))
  expect_equal(sum(x), new_ethdifftime(sum(1:5)))

  expect_true(all(is.finite(x)))
  expect_false(any(is.infinite(x)))
  expect_false(any(is.nan(x)))

  expect_error(vec_math.ethdifftime("median", x), "Unsupported")
})

test_that("summary.ethdifftime returns summary of difftime", {
  x <- new_ethdifftime(c(1, 2, NA))
  res <- summary(x)
  expect_s3_class(res, c("summaryDefault", "difftime"))
  expect_named(res, c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max."))
})

