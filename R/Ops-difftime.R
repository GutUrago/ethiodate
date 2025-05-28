

# Arithmetic -----

#' @export
#' @importFrom vctrs vec_arith
#' @method vec_arith ethdifftime
vec_arith.ethdifftime <- function(op, x, y, ...) {
  UseMethod("vec_arith.ethdifftime", y)
}



#' @export
#' @method vec_arith.ethdifftime ethdifftime
vec_arith.ethdifftime.ethdifftime <- function(op, x, y, ...) {
  switch(
    op,
    "-" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "+" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}

#' @export
#' @method vec_arith.ethdifftime numeric
vec_arith.ethdifftime.numeric <- function(op, x, y, ...) {
  switch(
    op,
    "-" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "+" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "*" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "/" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}


#' @export
#' @importFrom vctrs vec_arith.numeric
#' @method vec_arith.numeric ethdifftime
vec_arith.numeric.ethdifftime <- function(op, x, y, ...) {
  switch(
    op,
    "-" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "+" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "*" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    "/" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}


#' @export
#' @method vec_arith.ethdifftime ethdate
vec_arith.ethdifftime.ethdate <- function(op, x, y, ...) {
  switch(
    op,
    "+" = eth_date(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}



# Math ----


#' @exportS3Method vctrs::vec_math
vec_math.ethdifftime <- function(.fn, .x, ...) {
  switch(
    .fn,
    mean = new_ethdifftime(vctrs::vec_math_base(.fn, .x, ...)),
    min = new_ethdifftime(vctrs::vec_math_base(.fn, .x, ...)),
    max = new_ethdifftime(vctrs::vec_math_base(.fn, .x, ...)),
    sum = new_ethdifftime(vctrs::vec_math_base(.fn, .x, ...)),
    `is.nan` = vctrs::vec_math_base(.fn, .x, ...),
    `is.finite` = vctrs::vec_math_base(.fn, .x, ...),
    `is.infinite` = vctrs::vec_math_base(.fn, .x, ...),
    stop(paste("Unsupported function for ethdate:", .fn))
  )
}


# Summary -----

#' @export
summary.ethdifftime <- function(object, digits = 12L, ...) {

  x <- vctrs::vec_data(object)
  x <- as.difftime(x, units = "days")
  summary(x, digits = digits, ...)
  }

