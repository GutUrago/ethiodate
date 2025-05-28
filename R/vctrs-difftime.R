

# Class ----

new_ethdifftime <- function(x = integer()) {
  if (!is.numeric(x)) {
    stop("`x` must be an integer vector.")
  }
  if (!is.integer(x)) {
    x <- as.integer(x)
  }
  vctrs::new_vctr(x, units = "days", class = "ethdifftime")
}


# Coercing ----

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.ethdifftime <- function(x, y, ...) new_ethdifftime()


#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.double <- function(x, y, ...) double()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.double.ethdifftime <- function(x, y, ...) double()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.integer <- function(x, y, ...) integer()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.integer.ethdifftime <- function(x, y, ...) integer()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.character <- function(x, y, ...) character()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.character.ethdifftime <- function(x, y, ...) character()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.logical <- function(x, y, ...) new_ethdifftime(integer())

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.logical.ethdifftime <- function(x, y, ...) new_ethdifftime(integer())



# Casting ----

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.integer <- function(x, to, ...) new_ethdifftime(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.integer.ethdifftime <- function(x, to, ...) vctrs::vec_data(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.character <- function(x, to, ...) new_ethdifftime(as.integer(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.character.ethdifftime <- function(x, to, ...) as.character(vctrs::vec_data(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.double <- function(x, to, ...) new_ethdifftime(as.integer(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.double.ethdifftime <- function(x, to, ...) as.numeric(vctrs::vec_data(x))



# Proxy ----


#' @exportS3Method vctrs::vec_proxy_compare
vec_proxy_compare.ethdifftime <- function(x, ...) as.difftime(vctrs::vec_data(x), units = "days")


#' @exportS3Method vctrs::vec_restore
vec_restore.ethdifftime <- function(x, to, ...) new_ethdifftime(x)


