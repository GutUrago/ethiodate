

#' Create Ethiopian Dates
#' @description
#' Convert or create an Ethiopian date.
#'
#'
#' @param x a numeric, Date, POSIXct or POSIXt vector used to construct an Ethiopian date.
#' @param format a character that specifies format of the date. Must include %Y for year,
#' %m for month, and %d for day
#' @param ... arguments that pass into methods.
#'
#' @details
#' `eth_date()` internally stores number of days since 1962-04-23 EC (equivalent to 1970-01-01 GC).
#' Days before 1962-04-23 EC are represented as negative integers.
#' This makes it easy to convert from and to base `Date` objects. This function does not
#' support time and timezone.
#'
#' @seealso [eth_make_date()]
#'
#' @returns
#' Returns a vector with an 'ethDate' class that can further be used as an Ethiopian date.
#'
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' eth_date(as.Date(0))
eth_date <- function(x, ...) {
  UseMethod("eth_date")
}

#' @export
eth_date.default <- function(x, ...) {
  new_ethdate(x)
}

#' @export
eth_date.Date <- function(x, ...) {
  x <- as.numeric(x)
  new_ethdate(x)
}

#' @export
eth_date.POSIXct <- function(x, ...) {
  x <- as.Date(x)
  eth_date(x)
}

#' @export
eth_date.POSIXt <- function(x, ...) {
  x <- as.Date(x)
  eth_date(x)
}

#' @export
#' @rdname eth_date
eth_date.character <- function(x, format = "%Y-%m-%d", ...) {

  if (!is.character(format) | length(format) != 1L) {
    stop("\"Format\" must be a characteter of length 1.")
  }

  pattern <- format

  valid_pattern <- stringr::str_count(pattern, "%\\w") == 3L &
    stringr::str_detect(pattern, "%Y") & stringr::str_detect(pattern, "%m") &
    stringr::str_detect(pattern, "%d")

  if (valid_pattern) {

    orders <- c(
      "year" = stringr::str_locate(format, "%Y")[1],
      "month" = stringr::str_locate(format, "%m")[1],
      "day" = stringr::str_locate(format, "%d")[1])

    orders <- sort(orders)
    orders[1:3] <- c(2, 3, 4)

    pattern <- stringr::str_replace(pattern, "%Y", "(\\\\d{4})")
    pattern <- stringr::str_replace(pattern, "%m", "(\\\\d{1,2})")
    pattern <- stringr::str_replace(pattern, "%d", "(\\\\d{1,2})")

  } else {
    stop("Format should be specied as %Y for year, %m for month, and %d for day.")
  }

  matches <- stringr::str_match(x, pattern)

  year <- as.integer(matches[,orders["year"]])
  month <- as.integer(matches[,orders["month"]])
  day <- as.integer(matches[,orders["day"]])

  eth_make_date(year, month, day)

}

# Casting ----

#' @export
as.Date.ethdate <- function(x, ...) {
  x <- as.numeric(x)
  as.Date(x)
}

#' @export
as.double.ethdate <- function(x, ...) {
  x <- unclass(x)
  as.double(x)
}

#' @export
as.character.ethdate <- function(x, ...) {
  format(x, ...)
}


# Parsing ----

#' Make Ethiopian Date
#'
#' @description
#' Make Ethiopian date object from year, month and day.
#'
#'
#' @param year an integer vector of Ethiopian year.
#' @param month an integer vector of Ethiopian month.
#' @param day an integer vector of Ethiopian day.
#'
#' @details
#' This function constructs an Ethiopian date object from three vectors of an equal length.
#' It validates the date and returns `NA` for invalid dates. It accounts for leap years.
#' The returned object can further be used.
#' If you want to convert it to Gregorian calendar, use `as.Date()`.
#'
#'
#' @returns
#' Returns a vector with an 'ethDate' class that can further be used as an Ethiopian date.
#'
#'
#' @author Gutama Girja Urago
#'
#' @seealso [eth_date()]
#'
#' @export
#'
#' @examples
#' eth_make_date(2017, 01, 15)
eth_make_date <- function(year, month, day) {

  if (!is.numeric(year) | !is.numeric(month) | !is.numeric(day)) {
    stop("Year, month, and day must be integer vectors.")
  }

  x <- eth_date_validate(year = year,
                         month = month,
                         day = day)
  new_ethdate(x)
}
