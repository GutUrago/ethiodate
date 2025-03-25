
#' @export
format.ethdate <- function(x, format = "%Y-%m-%d",
                           lang = c("amh", "lat", "en"), ...) {
  lang <- match.arg(lang, c("amh", "lat", "en"))
  date_components <- eth_date_components(x)
  out <- eth_format_date(date_components, format, lang)
  names(out) <- names(x)
  out
}

#' @export
print.ethdate <- function(x, max = NULL, ...) {
  if(is.null(max)) max <- getOption("max.print", 9999L)
  if(max < length(x)) {
    print(format(x[seq_len(max)]), max=max, ...)
    cat(' [ reached getOption("max.print") -- omitted',
        length(x) - max, 'entries ]\n')
  } else print(format(x), max=max, ...)
  invisible(x)
  }


#' @export
print.ethdiffday <- function(x, max = NULL, ...) {
  if(is.null(max)) max <- getOption("max.print", 9999L)
  x <- unclass(x)
  x <- paste("Time difference of", x, "days")
  if(max < length(x)) {
    print(format(x[seq_len(max)]), max=max, ...)
    cat(' [ reached getOption("max.print") -- omitted',
        length(x) - max, 'entries ]\n')
  } else print(format(x), max=max, ...)
  invisible(x)
  }


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
