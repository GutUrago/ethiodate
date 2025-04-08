



#' Ethiopian Date Utils
#' @description
#' Small functions that helps to extract parts of Ethiopian date objects.
#'
#'
#' @param x a vector of an Ethiopian date object.
#' @param lang a language. 'amh' for Amharic, 'lat' for Amharic written in Latin alphabets and
#' 'en' for English
#' @param abbreviate Do you want to get an abbreviated month or weekday names?
#' @param ... further arguments to be passed to specific methods.
#'
#' @returns
#' a vector
#'
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' if (FALSE) {
#' x <- eth_date("2017-01-01")
#' eth_year(x)
#' }
eth_year <- function(x) {
  if (!is_eth_date(x)) {
    stop("`x` must be an Ethiopian date object.")
  }
  x <- eth_date_components(x)
  sapply(x, \(x) x[["year"]])
}

#' @export
#' @rdname eth_year
eth_month <- function(x) {
  if (!is_eth_date(x)) {
    stop("`x` must be an Ethiopian date object.")
  }
  x <- eth_date_components(x)
  sapply(x, \(x) x[["month"]])
}


#' @export
#' @rdname eth_year
eth_monthname <- function(x, lang = c("amh", "lat", "en"),
                          abbreviate = FALSE) {
  lang <- match.arg(lang, c("amh", "lat", "en"))
  if (!is_eth_date(x)) {
    stop("`x` must be an Ethiopian date object.")
  }
  if (abbreviate) {
    format(x, format = "%b", lang = lang)
  } else {
    format(x, format = "%B", lang = lang)
  }
}

#' @export
#' @rdname eth_year
eth_day <- function(x) {
  if (!is_eth_date(x)) {
    stop("`x` must be an Ethiopian date object.")
  }
  x <- eth_date_components(x)
  sapply(x, \(x) x[["day"]])
}

#' @export
#' @rdname eth_year
eth_weekday <- function(x, lang = c("amh", "lat", "en"),
                        abbreviate = FALSE) {
  lang <- match.arg(lang, c("amh", "lat", "en"))
  if (!is_eth_date(x)) {
    stop("`x` must be an Ethiopian date object.")
  }
  if (abbreviate) {
    format(x, format = "%a", lang = lang)
  } else {
    format(x, format = "%A", lang = lang)
  }
}
