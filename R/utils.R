



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
  x <- eth_date_components(x)
  month <- sapply(x, \(x) x[["month"]])

  if (!abbreviate) {
    if (lang == "amh") {
      months_amh_full[month]
    } else if (lang == "lat") {
      months_lat_full[month]
    } else if (lang == "en") {
      months_en_full[month]
    }
  } else {
    if (lang == "amh") {
      months_amh_short[month]
    } else if (lang == "lat") {
      months_lat_short[month]
    } else if (lang == "en") {
      months_en_short[month]
    }
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
  x <- eth_date_components(x)
  wx <- sapply(x, \(x) x[["wx"]])

  if (!abbreviate) {
    if (lang == "amh") {
      weekdays_amh_full[wx]
    } else if (lang == "lat") {
      weekdays_lat_full[wx]
    } else if (lang == "en") {
      weekdays_en_full[wx]
    }
  } else {
    if (lang == "amh") {
      weekdays_amh_short[wx]
    } else if (lang == "lat") {
      weekdays_lat_short[wx]
    } else if (lang == "en") {
      weekdays_en_short[wx]
    }
  }
}

#' @export
#' @rdname eth_year
is_eth_date <- function(x) {
  inherits(x, "ethDate")
}

#' @export
#' @rdname eth_year
is_eth_leap <- function(x) UseMethod("is_eth_leap")

#' @export
is_eth_leap.numeric <- function(x) {
  eth_leap_year(x)
}

#' @export
is_eth_leap.ethDate <- function(x) {
  x <- eth_date_components(x)
  y <- sapply(x, \(x) x[["year"]])
  eth_leap_year(y)
}

# Classes ----

new_ethDate <- function(x = integer()) {
  if (!is.numeric(x)) {
    stop("`x` must be an integer vector.")
  }
  vctrs::new_vctr(x, class = "ethDate")
}

new_ethDiffDay <- function(x = integer()) {
  if (!is.numeric(x)) {
    stop("`x` must be an integer vector.")
  }
  vctrs::new_vctr(x, class = "ethDiffDay")
}

# Month and weekday names ----

# Written using stringi::stri_escape_unicode()
months_amh_full <- c(
  "\u1218\u1235\u12a8\u1228\u121d", "\u1325\u1245\u121d\u1275",
  "\u1205\u12f3\u122d", "\u1273\u1205\u1233\u1235",
  "\u1325\u122d", "\u12e8\u12ab\u1272\u1275",
  "\u1218\u130b\u1262\u1275", "\u121a\u12eb\u12dd\u12eb",
  "\u130d\u1295\u1266\u1275", "\u1230\u1294",
  "\u1210\u121d\u120c", "\u1290\u1210\u1234", "\u1333\u1309\u121c"
)

months_amh_short <- c(
  "\u1218\u1235", "\u1325\u1245", "\u1205\u12f3", "\u1273\u1205",
  "\u1325\u122d", "\u12e8\u12ab", "\u1218\u130b", "\u121a\u12eb",
  "\u130d\u1295", "\u1230\u1294", "\u1210\u121d", "\u1290\u1210",
  "\u1333\u1309"
)

months_lat_full <- c("Meskerem", "Tikimt", "Hidar", "Tahsas", "Tir", "Yekatit",
                     "Megabit", "Miyazya", "Ginbot", "Sene", "Hamle", "Nehase",
                     "Pagume")

months_lat_short <- c("Mesk", "Tik", "Hid", "Tah", "Tir", "Yek", "Meg", "Miy",
                      "Gin", "Sen", "Ham", "Neh", "Pag")

months_en_full <- c("September", "October", "November", "December", "January",
                    "February", "March", "April", "May", "June", "July", "August",
                    "Pagume")

months_en_short <- c("Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr",
                     "May", "Jun", "Jul", "Aug", "Pag")

weekdays_amh_full <- c("\u1230\u129e", "\u121b\u12ad\u1230\u129e", "\u1228\u1261\u12d5",
                       "\u1210\u1219\u1235", "\u12d3\u122d\u1265", "\u1245\u12f3\u121c",
                       "\u12a5\u1201\u12f5")

weekdays_amh_short <- c("\u1230\u129e", "\u121b\u12ad", "\u1228\u1261", "\u1210\u1219",
                        "\u12d3\u122d", "\u1245\u12f3", "\u12a5\u1201")

weekdays_lat_full <- c("Segno", "Maksegno", "Rebu", "Hamus", "Arb", "Kidame", "Ehud")
weekdays_lat_short <- c("Seg", "Mak", "Reb", "Ham", "Arb", "Kid", "Ehu")
weekdays_en_full <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
weekdays_en_short <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
