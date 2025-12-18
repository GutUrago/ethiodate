

# Arithmetic -----

#' @export
#' @importFrom vctrs vec_arith
#' @method vec_arith ethdate
vec_arith.ethdate <- function(op, x, y, ...) {
  UseMethod("vec_arith.ethdate", y)
}



#' @export
#' @method vec_arith.ethdate ethdate
vec_arith.ethdate.ethdate <- function(op, x, y, ...) {
  switch(
    op,
    "-" = new_ethdifftime(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}

#' @export
#' @method vec_arith.ethdate numeric
vec_arith.ethdate.numeric <- function(op, x, y, ...) {
  switch(
    op,
    "-" = new_ethdate(vctrs::vec_arith_base(op, x, y)),
    "+" = new_ethdate(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}


#' @export
#' @importFrom vctrs vec_arith.numeric
#' @method vec_arith.numeric ethdate
vec_arith.numeric.ethdate <- function(op, x, y, ...) {
  switch(
    op,
    "+" = new_ethdate(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}


#' @export
#' @method vec_arith.ethdate ethdifftime
vec_arith.ethdate.ethdifftime <- function(op, x, y, ...) {
  switch(
    op,
    "-" = new_ethdate(vctrs::vec_arith_base(op, x, y)),
    "+" = new_ethdate(vctrs::vec_arith_base(op, x, y)),
    vctrs::stop_incompatible_op(op, x, y)
  )
}


# Math ----


#' @exportS3Method vctrs::vec_math
vec_math.ethdate <- function(.fn, .x, ...) {
  switch(
    .fn,
    mean = eth_date(vctrs::vec_math_base(.fn, .x, ...)),
    min = eth_date(vctrs::vec_math_base(.fn, .x, ...)),
    max = eth_date(vctrs::vec_math_base(.fn, .x, ...)),
    `is.nan` = vctrs::vec_math_base(.fn, .x, ...),
    `is.finite` = vctrs::vec_math_base(.fn, .x, ...),
    `is.infinite` = vctrs::vec_math_base(.fn, .x, ...),
    cli::cli_abort("Unsupported function for {.cls ethdate}: {.fn {(.fn)}}.")
  )
}


# Summary -----

#' @export
summary.ethdate <- function(object, digits = 12L, ...) {

  x <- summary.default(unclass(object), digits = digits, ...)
  stat_names <- names(x)
  if(m <- match("NA's", names(x), 0)) {
    NAs <- as.character(as.integer(x[m]))
    x <- as.character(new_ethdate(x[-m]))
    x <- c(x, "NA's" = NAs)
  } else {
    x <- as.character(new_ethdate(x))
    }
  names(x) <- stat_names
  x
  }

# Sequence ----

#' @export
seq.ethdate <- function(from, to = NULL, by = NULL,
                        length.out = NULL, along.with = NULL, ...) {
  vctrs::vec_assert(from, new_ethdate(), size = 1L)
  if (!is.null(to)) {
    vctrs::vec_assert(to, new_ethdate(), size = 1L)
  }
  if (!is.null(by)) {
    if (is.numeric(by)) by <- as.integer(by)
    vctrs::vec_assert(by, integer(), size = 1L)
  }
  if (!is.null(along.with)) {
    if (!is.null(length.out)) stop("Please specify only one of 'length.out' / 'along.with'")
    length.out <- length(along.with)
  }
  if (!is.null(length.out)) {
    if (is.numeric(length.out)) length.out <- as.integer(length.out)
    vctrs::vec_assert(length.out, integer(), size = 1L)
    length.out <- ceiling(length.out)
  }
  status <- c(!is.null(to), !is.null(by), !is.null(length.out))
  if(sum(status) != 2L)
    stop("Exactly two of 'to', 'by' and 'length.out' / 'along.with' must be specified")

  if (!is.null(to) & !is.null(length.out)) {
    from <- vctrs::vec_data(from)
    to <- vctrs::vec_data(to)
    out <- seq.int(from, to, length.out = length.out)
  } else if (!is.null(to) & !is.null(by)) {
    from <- vctrs::vec_data(from)
    to <- vctrs::vec_data(to)
    out <- seq.int(from, to, by = by)
  } else {
    from <- vctrs::vec_data(from)
    out <- seq.int(from, by = by, length.out = length.out)
  }
  return(new_ethdate(out))
}


# Cut ----

#' @export
cut.ethdate <- function(x,
                        breaks,
                        labels = NULL,
                        include.lowest = TRUE,
                        right = TRUE,
                        ...) {
  if (!inherits(x, "ethdate")) stop("'x' must be an 'ethdate' object")

  x_num <- as.numeric(x)

  if (inherits(breaks, "ethdate")) {
    breaks <- sort(as.numeric(breaks))
  } else if (is.numeric(breaks) && length(breaks) == 1L) {
    rng <- range(x_num, na.rm = TRUE)
    breaks <- seq(rng[1], rng[2], length.out = breaks + 1L)
  } else stop("invalid specification of 'breaks'")

  res <- cut(x_num, breaks, labels = labels, ...)

  if (is.null(labels)) {
    levels(res) <- as.character(eth_date(breaks[-length(breaks)]))
  }
  return(res)
}

