



#' @title Date Conversion Functions to Ethiopian Date
#'
#' @description
#' These functions can parse an Ethiopian date from integers, and characters.
#' It can seamlessly convert Ethiopian date to and from Gregorian calendar.
#' At the moment, there's no function that supports timezone and hours.
#'
#' @param x an integer, character, or date objects to be parsed as an Ethiopian date
#' @param sep if `x` is a character, an separator of year, month and day.
#' @param orders if `x` is a character, the order of year (y), month (m) and day (d)
#' in the character. Default is "ymd".
#' @param ... Arguments that passes to and from methods. Must be empty.
#'
#' @return A vector of "ethDate" class.
#'
#' @author Gutama Girja Urago
#'
#' @export
#' @examples
#' as_eth_date("2000-01-01")
as_eth_date <- function(x, ...) UseMethod("as_eth_date")

#' @export
#' @rdname as_eth_date
as_eth_date.numeric <- function(x, ...) {
  as_eth_date_cpp(as.integer(x))
}


#' @export
#' @rdname as_eth_date
as_eth_date.integer <- function(x, ...) {
  as_eth_date_cpp(x)
}

#' @export
#' @rdname as_eth_date
as_eth_date.character <- function(x, ..., sep = "-", orders = "ymd") {
  eth_date <- parse_eth_date_cpp(x, ..., sep = sep, orders = orders)
  if (all(is.na(eth_date))) {
    stop("Could not parse the date.")
  }
  return(eth_date)
}

#' @export
#' @rdname as_eth_date
as_eth_date.Date <- function(x, ...) {
  numeric_date <- as.numeric(x)
  as_eth_date(numeric_date)
}

# # Think about timezones
# #' @export
# #' @rdname as_eth_date
# as_eth_date.POSIXlt <- function(x, ...) {
#   gre_date <- as.Date(x)
#   as_eth_date(gre_date)
# }




#' @title Date Conversion Functions to and from Ethiopian Date
#'
#' @description
#' Functions to convert an Ethiopian date to and from Gregorian calendar.
#' At the moment, there's no function that supports timezone and hours.
#'
#' @param x a Date or ethDate object
#'
#' @param ... Arguments that passes to and from methods. Must be empty.
#'
#' @return Except `as_numeric`, return an object with "Date" class if converted to Gregorian,
#' else an object with "ethDate" class. `as_numeric` returns number of days since 1970-01-01,
#' which can easily be converted to Gregorian date using `as.Date`.
#'
#' @author Gutama Girja Urago
#'
#' @export
#' @examples
#' date <- as.Date("2025-01-01")
#' eth_date <- to_ethiopian(date)
to_gregorian <- function(x, ...) {
  if (!inherits(x, "ethDate")) {
    stop("Only objects with 'ethDate' can be converted.")
  }
  eth_numeric <- to_numeric_cpp(x)
  gre_date <- as.Date(eth_numeric, ...)
  return(gre_date)
}

#' @export
#' @rdname to_gregorian
to_ethiopian <- function(x) {
  if (!inherits(x, "Date")) {
    stop("Only objects with 'Date' can be converted.")
  }
  gre_numeric <- base::as.numeric(x)
  gre_date <- as_eth_date(gre_numeric)
  return(gre_date)
}

#' @export
#' @rdname to_gregorian
as_gre_date <- function(x, ...) {
  to_gregorian(x, ...)
}

#' @export
#' @rdname to_gregorian
as_numeric <- function(x, ...) {
  to_numeric_cpp(x)
}

# Operators ----

#' @export
`+.ethDate` <- function(x, y) {
  if (!is.numeric(y)) {
    stop("Only 'numeric' can be added to an object with 'ethDate' class.")
  }
  x <- to_numeric_cpp(x)
  date_integer <- x + y
  eth_date <- as_eth_date(date_integer)
  return(eth_date)
}


#' @export
`-.ethDate` <- function(x, y) {
  # Add for date differences
  x <- to_numeric_cpp(x)
  if (is.numeric(y)) {
    difference <- x - y
    difference <- as_eth_date(difference)
  } else {
    if (!inherits(x, "ethDate")) {
      stop("Cannot add to an 'ethDate' object.")
    }
    y <- to_numeric_cpp(y)
    difference <- x - y
    class(difference) <- "ethDiffDays"
  }
  return(difference)
}


#' @export
print.ethDiffDays <- function(x, max = NULL, ...) {
  if(is.null(max)) max <- getOption("max.print", 9999L)
  is_longer <- length(x) > max
  if (is_longer) {
    omit <- length(x) - max
    x <- x[1:max]
  }
  for (i in seq_along(x)) {
    cat("The time difference is", x[i], "days.\n")
  }
  if (is_longer) {
    cat(' [ reached getOption("max.print") -- omitted',
        omit, 'entries ]\n')
  }
}


