
#' @export
format.ethdate <- function(x, format = "%Y-%m-%d",
                           lang = c("amh", "lat", "en"), ...) {
  lang <- match.arg(lang, c("amh", "lat", "en"))
  if (!is.character(format) | length(format) != 1L) {
    stop("\"Format\" must be a characteter of length 1.")
  }
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
