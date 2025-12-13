

# Class ----

new_ethdifftime <- function(x = double()) {
  vctrs::new_vctr(as.double(x), units = "days", class = c("ethdifftime", "difftime"))
}


# Coercing ----

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.ethdifftime <- function(x, y, ...) new_ethdifftime()


#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.double <- function(x, y, ...) new_ethdifftime()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.double.ethdifftime <- function(x, y, ...) new_ethdifftime()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.integer <- function(x, y, ...) new_ethdifftime()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.integer.ethdifftime <- function(x, y, ...) new_ethdifftime()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.character <- function(x, y, ...) character()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.character.ethdifftime <- function(x, y, ...) character()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.ethdifftime.logical <- function(x, y, ...) new_ethdifftime()

#' @exportS3Method vctrs::vec_ptype2
vec_ptype2.logical.ethdifftime <- function(x, y, ...) new_ethdifftime()



# Casting ----

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.integer <- function(x, to, ...) new_ethdifftime(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.integer.ethdifftime <- function(x, to, ...) as.integer(vctrs::vec_data(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.character <- function(x, to, ...) new_ethdifftime(as.integer(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.character.ethdifftime <- function(x, to, ...) as.character(vctrs::vec_data(x))

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.double <- function(x, to, ...) new_ethdifftime(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.double.ethdifftime <- function(x, to, ...) vctrs::vec_data(x)

#' @exportS3Method vctrs::vec_cast
vec_cast.ethdifftime.logical <- function(x, to, ...) new_ethdifftime(rep(NA_real_, length(x)))

#' @exportS3Method vctrs::vec_cast
vec_cast.logical.ethdifftime <- function(x, to, ...) as.logical(vctrs::vec_data(x))



# Proxy ----


#' @exportS3Method vctrs::vec_proxy_compare
vec_proxy_compare.ethdifftime <- function(x, ...) as.difftime(vctrs::vec_data(x), units = "days")


#' @exportS3Method vctrs::vec_restore
vec_restore.ethdifftime <- function(x, to, ...) new_ethdifftime(x)


