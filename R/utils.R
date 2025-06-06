


#' Utils
#'
#' @description
#' Small helper functions.
#'
#'
#' @param x an ethdate or numeric vector.
#' @param format a format for character date.
#' @param lang a language.
#' @param ... further arguments to be passed to specific methods.
#'
#' @returns
#' `is_eth_leap()` returns a boolean vector,
#' `as.Date()` returns a Date object,
#' `as.numeric()` returns number of date since 1970-01-01 GC (1962-04-23 EC), and
#' `as.character()` returns formatted character date.
#'
#'
#' @export
#'
#' @examples
#' is_eth_leap(2011)
is_eth_date <- function(x) {
  inherits(x, "ethdate")
}

#' @export
#' @rdname is_eth_date
is_eth_leap <- function(x) UseMethod("is_eth_leap")

#' @export
is_eth_leap.numeric <- function(x) {
  eth_leap_year(x)
}

#' @export
is_eth_leap.ethdate <- function(x) {
  x <- eth_date_components(x)
  y <- sapply(x, \(x) x[["year"]])
  eth_leap_year(y)
}

#' @export
#' @rdname is_eth_date
as.Date.ethdate <- function(x, ...) {
  x <- as.numeric(x)
  as.Date(x)
}

#' @export
#' @rdname is_eth_date
as.double.ethdate <- function(x, ...) as.double(vctrs::vec_data(x))


#' @export
#' @rdname is_eth_date
as.character.ethdate <- function(x, ...) format(x, ...)

#' @export
#' @rdname is_eth_date
format.ethdate <- function(x, format = "%Y-%m-%d",
                           lang = c("lat", "amh", "en"), ...) {
  lang <- match.arg(lang, c("lat", "amh", "en"))
  if (!is.character(format) | length(format) != 1L) {
    stop("\"Format\" must be a characteter of length of 1.")
  }
  date_components <- eth_date_components(x)
  out <- eth_format_date(date_components, format, lang)
  names(out) <- names(x)
  out
}





#' See Month or Day Names
#'
#' @description
#' Small functions that displays texts.
#'
#'
#' @param x what you want to see.
#' @param lang language of the text.
#' @param ... arguments that passes to [format()]
#'
#' @details
#' `eth_show()` displays the underlying month and weekday names that is used by [eth_parse_date()].
#'
#' @returns
#' Except for `eth_date()`, which returns an `ethdate` object, other functions return a character vector.
#'
#' @author Gutama Girja Urago
#'
#'
#' @export
#'
#' @examples
#' eth_show()
#' eth_show("%A", "amh")
#' eth_today()
#' eth_now()
#'
eth_show <- function(x = c("%B", "%b", "%A", "%a"),
                     lang = c("lat", "amh", "en")) {

  x <- match.arg(x, c(c("%B", "%b", "%A", "%a")))
  lang <- match.arg(lang, c("lat", "amh", "en"))

  m_names <- as.character(1:13)
  d_names <- as.character(1:7)

  if (x == "%B") {
    if (lang == "amh") {
      out <- months_amh_full
      names(out) <- m_names
      return(out)
      }
    if (lang == "lat") {
      out <- months_lat_full
      names(out) <- m_names
      return(out)
    }
    if (lang == "en") {
      out <- months_en_full
      names(out) <- m_names
      return(out)
    }
  } else if (x == "%b") {
    if (lang == "amh") {
      out <- months_amh_short
      names(out) <- m_names
      return(out)
    }
    if (lang == "lat"){
      out <- months_lat_short
      names(out) <- m_names
      return(out)
    }
    if (lang == "en"){
      out <- months_en_short
      names(out) <- m_names
      return(out)
    }
  } else if (x == "%A") {
    if (lang == "amh") {
      out <- weekdays_amh_full
      names(out) <- d_names
      return(out)
    }
    if (lang == "lat") {
      out <- weekdays_lat_full
      names(out) <- d_names
      return(out)
    }
    if (lang == "en") {
      out <- weekdays_en_full
      names(out) <- d_names
      return(out)
    }
  } else if (x == "%a") {
    if (lang == "amh") {
      out <- weekdays_amh_short
      names(out) <- d_names
      return(out)
    }
    if (lang == "lat") {
      out <- weekdays_lat_short
      names(out) <- d_names
      return(out)
    }
    if (lang == "en") {
      out <- weekdays_en_short
      names(out) <- d_names
      return(out)
    }
  }
}

#' @export
#' @rdname eth_show
eth_today <- function(...) {
  x <- eth_date(Sys.Date())
  if (length(list(...)) == 0) {
    return(x)
  } else {
    return(format(x, ...))
  }
}

#' @export
#' @rdname eth_show
eth_now <- function(...) {
  s <- Sys.time()
  attr(s,"tzone") <- "Africa/Addis_Ababa"
  t <- format(s, format = "%I:%M:%S %p")
  s <- format(eth_date(s), ...)
  paste(s, t)
}






