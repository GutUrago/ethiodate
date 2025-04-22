test_that("Eth now is just a formatted character", {
  expect_true(inherits(eth_now(), "character"))
})

test_that("Eth today is date object", {
  expect_true(inherits(eth_today(), "ethdate"))
  expect_true(inherits(eth_today(format = "%B"), "character"))
})




