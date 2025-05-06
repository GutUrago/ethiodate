



#' Ethiopian Date Utils
#' @description
#' Small functions that helps to extract parts of Ethiopian date objects.
#'
#'
#' @param x a vector of an Ethiopian date object
#' @param lang a language. 'amh' for Amharic, 'lat' for Amharic written in Latin alphabets and
#' 'en' for English
#' @param abbreviate Do you want to get an abbreviated month or weekday names?
#'
#' @returns
#' a vector
#'
#' @author Gutama Girja Urago
#' @export
#'
#' @examples
#' today <- eth_date(Sys.Date())
#' eth_year(today)
#' eth_month(today)
#' eth_monthname(today)
#' eth_day(today)
#' eth_weekday(today)
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
eth_monthname <- function(x, lang = c("lat", "amh", "en"),
                          abbreviate = FALSE) {
  lang <- match.arg(lang, c("lat", "amh", "en"))
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
eth_weekday <- function(x, lang = c("lat", "amh", "en"),
                        abbreviate = FALSE) {
  lang <- match.arg(lang, c("lat", "amh", "en"))
  if (!is_eth_date(x)) {
    stop("`x` must be an Ethiopian date object.")
  }
  if (abbreviate) {
    format(x, format = "%a", lang = lang)
  } else {
    format(x, format = "%A", lang = lang)
  }
}
