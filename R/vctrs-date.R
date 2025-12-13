
# Class ----

new_ethdate <- function(x = double()) {
  vctrs::new_vctr(as.double(x), class = "ethdate")
}


# Coercing ----

# ethdate with itself

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdate.ethdate <- function(x, y, ...) new_ethdate()

# ethdate with numeric

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdate.double  <- function(x, y, ...) new_ethdate()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.double.ethdate  <- function(x, y, ...) new_ethdate()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdate.integer <- function(x, y, ...) new_ethdate()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.integer.ethdate <- function(x, y, ...) new_ethdate()

# ethdate with character → return character prototype

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdate.character <- function(x, y, ...) new_ethdate()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.character.ethdate <- function(x, y, ...) new_ethdate()

# ethdate with logical → return ethdate prototype

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdate.logical <- function(x, y, ...) new_ethdate()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.logical.ethdate <- function(x, y, ...) new_ethdate()


# Casting ----

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdate.integer <- function(x, to, ...) new_ethdate(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.integer.ethdate <- function(x, to, ...) as.integer(vctrs::vec_data(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdate.double <- function(x, to, ...) new_ethdate(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.double.ethdate <- function(x, to, ...) as.double(vctrs::vec_data(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdate.character <- function(x, to, ...) as_ethdate(x, ...)

#' @exportS3Method vctrs::vec_cast
vec_cast.character.ethdate <- function(x, to, ...) as.character(x, ...)

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdate.logical <- function(x, to, ...) new_ethdate(rep(NA_real_, length(x)))

#' @exportS3Method vctrs::vec_cast
vec_cast.logical.ethdate <- function(x, to, ...) as.logical(vctrs::vec_data(x))


# Proxy ----

#' @exportS3Method vctrs::vec_proxy_compare
vec_proxy_compare.ethdate <- function(x, ...) vctrs::vec_data(x)

#' @exportS3Method vctrs::vec_restore
vec_restore.ethdate <- function(x, to, ...) new_ethdate(x)

