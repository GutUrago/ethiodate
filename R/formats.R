

#' @export
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

#' @export
print.ethdate <- function(x, max = NULL, ...) {
  if(is.null(max)) max <- getOption("max.print", 9999L)
  n <- length(x)
  if(max < n) {
    print(format(x[seq_len(max)]), max=max, ...)
    cat(' [ reached getOption("max.print") -- omitted',
        n - max, 'entries ]\n')
  } else print(format(x), max=max, ...)
  invisible(x)
  }


#' @export
print.ethdiffday <- function(x, max = NULL, ...) {
  if(is.null(max)) max <- getOption("max.print", 9999L)
  x <- unclass(x)
  x <- paste("Time difference of", x, "days")
  n <- length(x)
  if(max < n) {
    print(format(x[seq_len(max)]), max=max, ...)
    cat(' [ reached getOption("max.print") -- omitted',
        n - max, 'entries ]\n')
  } else print(format(x), max=max, ...)
  invisible(x)
  }

# Formats and names ----

eth_format_date <- function(x, format, lang, ...) {

  year <- sapply(x, \(x) x[["year"]])
  month <- sapply(x, \(x) x[["month"]])
  day <- sapply(x, \(x) x[["day"]])
  td <- sapply(x, \(x) x[["td"]])
  wx <- sapply(x, \(x) x[["wx"]])

  cont_Y <- grepl("%Y", format)
  cont_y <- grepl("%y", format)
  cont_m <- grepl("%m", format)
  cont_d <- grepl("%d", format)
  cont_A <- grepl("%A", format)
  cont_a <- grepl("%a", format)
  cont_B <- grepl("%B", format)
  cont_b <- grepl("%b", format)

  formatted <- rep(format, length.out = length(year))

  for (i in seq_along(year)) {
    if (is.na(year[i])) {
      formatted[i] <- NA_character_
      next
    }
    if (cont_Y) {
      formatted[i] <- gsub("%Y", year[i], formatted[i])
    }
    if (cont_y) {
      formatted[i] <- gsub("%y", substr(year[i], 3, 4), formatted[i])
    }
    if (cont_m) {
      formatted[i] <- gsub("%m", sprintf("%02d", month[i]), formatted[i])
    }
    if (cont_d) {
      formatted[i] <- gsub("%d", sprintf("%02d", day[i]), formatted[i])
    }
    if (cont_a | cont_A) {
      if (cont_a) {
        formatted[i] <- if (lang == "amh") {
          gsub("%a", weekdays_amh_short[wx[i]], formatted[i])
        } else if (lang == "lat") {
          gsub("%a", weekdays_lat_short[wx[i]], formatted[i])
        } else {
          gsub("%a", weekdays_en_short[wx[i]], formatted[i])
        }
      }
      if (cont_A) {
        formatted[i] <- if (lang == "amh") {
          gsub("%A", weekdays_amh_full[wx[i]], formatted[i])
        } else if (lang == "lat") {
          gsub("%A", weekdays_lat_full[wx[i]], formatted[i])
        } else {
          gsub("%A", weekdays_en_full[wx[i]], formatted[i])
        }
      }
    }
    if (cont_b) {
      formatted[i] <- if (lang == "amh") {
        gsub("%b", months_amh_short[month[i]], formatted[i])
      } else if (lang == "lat") {
        gsub("%b", months_lat_short[month[i]], formatted[i])
      } else {
        gsub("%b", months_en_short[month[i]], formatted[i])
      }
    }
    if (cont_B) {
      formatted[i] <- if (lang == "amh") {
        gsub("%B", months_amh_full[month[i]], formatted[i])
      } else if (lang == "lat") {
        gsub("%B", months_lat_full[month[i]], formatted[i])
      } else {
        gsub("%B", months_en_full[month[i]], formatted[i])
      }
    }
  }
  formatted
}

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
