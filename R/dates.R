

#' Create an Ethiopian Date Object
#'
#' @description
#' Convert an object to an Ethiopian date.
#'
#'
#' @param x a numeric, character, Date, POSIXct or POSIXt vector.
#' @param origin a ethdate or Date object, or something that can be coerced by
#' `eth_date(origin, ...)`. Default: the Unix epoch of "1970-01-01" GC ("1962-04-23" EC).
#' @param format format argument for character method to parse the date.
#' @param lang a language in which month names are written, if included in x.
#' Use "lat" for Amharic month names written in Latin alphabets, "amh" for month names
#' written in Amharic alphabets, and "en" for English month names.
#' @param ... further arguments to be passed to specific methods (see above).
#'
#' @details
#' `eth_date()` internally stores the number of days as an integer since the Unix epoch of "1970-01-01" GC ("1962-04-23" EC).
#' Days before "1962-04-23" EC are represented as negative integers.
#' This makes it easy to convert from and to base `Date` objects.
#'
#' The conversion of numeric vectors assumes that the vector represents a number of days since
#' the origin ("1962-04-23" EC if origin is NULL). For the date objects, it extracts underlying
#' numeric values and convert it to an `ethiodate` object. To convert from POSIXct or POSIXt,
#' it coerces these objects to base Date objects and then applies the conversion.
#'
#' To parse a character vector, a valid format must be supplied. The default is "%Y-%m-%d".
#' Please see the details section of \code{\link[base]{strptime}}. Factors can also be coerced
#' to `ethdate` after being internally converted to character.
#'
#'
#' @seealso [eth_make_date()] [eth_parse_date()]
#'
#' @returns
#' a vector of an 'ethdate' object corresponding to x.
#'
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#'
#' eth_date(Sys.Date())
#' eth_date(Sys.time())
#'
#' x <- 7
#' eth_date(x)
#' eth_date(x, origin = Sys.Date())
#' eth_date(x, origin = eth_today())
#' eth_date(x, origin = "2017-01-01")
#' eth_date(x, origin = "01-01-2017", format = "%d-%m-%Y")
#'
#' s <- c("01/01/2013", "06/13/2011")
#' eth_date(s, format = "%d/%m/%Y")
#'
#'
#'
eth_date <- function(x, ...) {
  UseMethod("eth_date")
}

#' @export
eth_date.default <- function(x, ...) {
  new_ethdate(x)
}

#' @rdname eth_date
#' @export
eth_date.numeric <- function(x, origin = NULL, ...) {
  if (length(origin) != 1L & !is.null(origin)) {
    stop("\"origin\" must be a vector of length 1 that is either a Date or ethdate object, or something that can be coerced to ethdate.")
  }

  if (!is.null(origin) & inherits(origin, "ethdate")) {
    origin <- as.numeric(origin)
  } else if (!is.null(origin)) {
    origin <- as.numeric(eth_date(origin, ...))
  } else {
    origin <- 0
  }

  if (is.na(origin)) {
    stop("Unable to coerce \"origin\" to ethdate.")
  }

  if (origin == 0) {
    new_ethdate(x)
  } else {
    new_ethdate(x) + origin
  }
}

#' @rdname eth_date
#' @export
eth_date.character <- function(x, format = "%Y-%m-%d",
                               lang = c("lat", "amh", "en"), ...) {
  eth_parse_date(x, format, lang)
}


#' @rdname eth_date
#' @export
eth_date.Date <- function(x, ...) {
  x <- as.numeric(x)
  new_ethdate(x)
}

#' @rdname eth_date
#' @export
eth_date.POSIXct <- function(x, ...) {
  x <- as.Date(x)
  eth_date(x)
}

#' @rdname eth_date
#' @export
eth_date.POSIXt <- function(x, ...) {
  x <- as.Date(x)
  eth_date(x)
}

#' @rdname eth_date
#' @export
eth_date.factor <- function(x, ...) eth_date(as.character(x), ...)






#' Make Ethiopian Date
#'
#' @description
#' Make Ethiopian date from year, month and day components.
#'
#'
#' @param year an integer vector of Ethiopian year.
#' @param month an integer vector of Ethiopian month.
#' @param day an integer vector of Ethiopian day.
#'
#' @details
#' This function makes an Ethiopian date object from three integer vectors of an equal length.
#' It validates the date and returns `NA` for invalid dates. It accounts for leap years.
#'
#'
#' @returns
#' a vector of an 'ethdate' object.
#'
#'
#' @author Gutama Girja Urago
#'
#' @seealso [eth_date()] [eth_parse_date()]
#'
#' @export
#'
#' @examples
#' eth_make_date(2017, 01, 15)
eth_make_date <- function(year, month, day) {
  if (!is.numeric(year) | !is.numeric(month) | !is.numeric(day)) {
    stop("Year, month, and day must be integer vectors.")
  }
  x <- eth_date_validate(year = year, month = month, day = day)
  new_ethdate(x)
}



#' Parse Ethiopian Date
#'
#' @description
#' Parse Ethiopian date from character vector that has a non-digit separator.
#'
#'
#' @param x a character vector.
#' @param format a format in in which x is composed. See \code{\link[base]{strptime}}.
#' @param lang a language in which month names are written, if included in x.
#' Use "lat" for Amharic month names written in Latin alphabets, "amh" for month names
#' written in Amharic alphabets, and "en" for English month names.
#'
#' @details
#' x must include a non-digit separator and exactly three components of the date (year, month, and day).
#'
#'
#' @returns
#' a vector of  an'ethdate' object.
#'
#' @author Gutama Girja Urago
#'
#' @seealso [eth_date()] [eth_make_date()]
#'
#' @export
#'
#' @examples
#' eth_parse_date("2017-01-01")
#' s <- c("01/01/2013", "06/13/2011")
#' eth_parse_date(s, format = "%d/%m/%Y")
eth_parse_date <- function(x, format = "%Y-%m-%d",
                           lang = c("lat", "amh", "en")) {
  lang <- match.arg(lang, c("lat", "amh", "en"))
  if (!is.character(format) | length(format) != 1L) {
    stop("\"Format\" must be a characteter of length 1.")
  }

  if (!is.character(x)) {
    stop("\"x\" must be a character vector.")
  }

  x <- stringr::str_squish(x)
  format <- stringr::str_squish(format)

  valid_format <- stringr::str_count(format, "%\\w") == 3L

  if (!valid_format) {
    stop("\"format\" must include exactly 3 components: year, month, and day.")
  }

  valid_year <- sum(stringr::str_detect(format, "%Y") |
    stringr::str_detect(format, "%y")) == 1L

  if (!valid_year) {
    stop("\"format\" must include exactly 1 year component: %Y or %y.")
  }

  valid_month <- sum(stringr::str_detect(format, "%m") |
    stringr::str_detect(format, "%B") |
    stringr::str_detect(format, "%b")) == 1L

  if (!valid_month) {
    stop("\"format\" must include exactly 1 month component: %m, %B, or %b.")
  }

  valid_day <- sum(stringr::str_detect(format, "%d")) == 1L
  if (!valid_day) {
    stop("\"format\" must include exactly 1 day component: %d.")
  }

  orders <- c(
    "year" = stringr::str_locate(format, "%Y|%y")[1],
    "month" = stringr::str_locate(format, "%m|%B|%b")[1],
    "day" = stringr::str_locate(format, "%d")[1]
  )

  orders <- sort(orders)
  orders[1:3] <- c(2, 3, 4)

  td_y <- stringr::str_detect(format, "%y")
  full_m <- stringr::str_detect(format, "%B")
  short_m <- stringr::str_detect(format, "%b")

  if (!td_y) {
    format <- stringr::str_replace(format, "%Y", "(\\\\d{4})")
  } else {
    format <- stringr::str_replace(format, "%y", "(\\\\d{2})")
  }

  if (stringr::str_detect(format, "%m")) {
    format <- stringr::str_replace(format, "%m", "(\\\\d{1,2})")
  } else if (full_m) {
    format <- stringr::str_replace(format, "%B", "(\\\\w{1,})")
  } else {
    format <- stringr::str_replace(format, "%b", "(\\\\w{1,})")
  }

  format <- stringr::str_replace(format, "%d", "(\\\\d{1,2})")

  matches <- stringr::str_match(x, format)

  year <- matches[, orders["year"]]
  month <- matches[, orders["month"]]
  day <- matches[, orders["day"]]

  if (td_y) {
    year <- paste0("20", year)
  }

  if (full_m) {
    if (lang == "amh") {
      month <- sapply(month, function(m) {
        if (!is.na(m)) {
          c(1:13)[months_amh_full == m]
        } else {
          NA
        }
      })
    } else if (lang == "lat") {
      month <- stringr::str_to_title(month)
      month <- sapply(month, function(m) {
        if (!is.na(m)) {
          c(1:13)[months_lat_full == m]
        } else {
          NA
        }
      })
    } else {
      month <- stringr::str_to_title(month)
      month <- sapply(month, function(m) {
        if (!is.na(m)) {
          c(1:13)[months_en_full == m]
        } else {
          NA
        }
      })
    }
  }

  if (short_m) {
    if (lang == "amh") {
      month <- sapply(month, function(m) {
        if (!is.na(m)) {
          c(1:13)[months_amh_short == m]
        } else {
          NA
        }
      })
    } else if (lang == "lat") {
      month <- stringr::str_to_title(month)
      month <- sapply(month, function(m) {
        if (!is.na(m)) {
          c(1:13)[months_lat_short == m]
        } else {
          NA
        }
      })
    } else {
      month <- stringr::str_to_title(month)
      month <- sapply(month, function(m) {
        if (!is.na(m)) {
          c(1:13)[months_en_short == m]
        } else {
          NA
        }
      })
    }
  }

  year <- as.integer(year)
  month <- as.integer(month)
  day <- as.integer(day)

  eth_make_date(year, month, day)
}
