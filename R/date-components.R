



#' Ethiopian Date Components
#' @description
#' Small functions that helps to extract parts of Ethiopian date objects.
#'
#'
#' @param x a vector of an Ethiopian date object
#' @param lang a language. 'lat' for Amharic written in Latin alphabets, 'amh' for Amharic, and
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
  get_component(x, "year")
}

#' @export
#' @rdname eth_year
eth_month <- function(x) {
  get_component(x, "month")
}

all(c(1, NA) > 0, na.rm = TRUE)
#' @export
#' @rdname eth_year
eth_monthname <- function(x, lang = c("lat", "amh", "en"),
                          abbreviate = FALSE) {
  lang <- match.arg(lang)
  if (!is_eth_date(x)) {
    valid <- FALSE
    if (is.numeric(x)) {
      valid <- all(x > 0 & x < 14, na.rm = TRUE)
      if (valid) x <- eth_make_date(2017, x, 1)
    }
    if (!valid) {
      cli::cli_abort(
        c(
          "x" = "The input {.var x} must be {.cls ethdate}.",
          "i" = "Current type of {.var x} is {.cls {class(x)}}."
        )
      )
    }
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
  get_component(x, "day")
}

#' @export
#' @rdname eth_year
eth_weekday <- function(x, lang = c("lat", "amh", "en"),
                        abbreviate = FALSE) {
  lang <- match.arg(lang)
  if (!is_eth_date(x)) {
    cli::cli_abort(
      c(
        "x" = "The input {.var x} must be {.cls ethdate}.",
        "i" = "Current type of {.var x} is {.cls {class(x)}}."
      )
    )
  }
  if (abbreviate) {
    format(x, format = "%a", lang = lang)
  } else {
    format(x, format = "%A", lang = lang)
  }
}

#' @export
#' @rdname eth_year
eth_quarter <- function(x) {
  x <- eth_month(x)
  Q <- ifelse(x < 4, 1,
              ifelse(x < 7, 2,
                     ifelse(x < 10, 3, 4)))

  ifelse(is.na(Q), NA_character_, paste0("Q", Q) )
}


