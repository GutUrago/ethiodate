

#' Plotting Ethiopian Date
#' @name ethdate-ggplot
#'
#' @description
#' Helper functions to plot an `ethdate` object using `ggplot2`.
#'
#'
#' @param breaks A numeric vector of positions or `eth_breaks()` function.
#' @param labels A character vector giving labels (must be same length as breaks) or
#' `eth_labels()` function.
#' @param n A number of breaks.
#' @param pretty Logical; if TRUE, use pretty() for rounded breaks.
#' @param format A format for the `ethdate`.
#' @param lang A language for the month or weekday names if involved. Use "lat" for Latin alphabets
#' "amh" for Amharic alphabets, and "en" for English names.
#' @param ... further arguments to be passed to [ggplot2::scale_x_continuous()] or [ggplot2::scale_y_continuous()].
#'
#' @details
#' `eth_labels()` and `eth_breaks()` are designed to be used only in the `scale_(x|y)_ethdate` functions.
#'
#'
#' @returns
#' Maps `ethdate` objects on `ggplot2` layers.
#'
#' @author Gutama Girja Urago
#'
#' @export
#'
#' @examples
#'
#' library(ggplot2)
#'
#' cpieth[["ethdt"]] <- eth_date(cpieth$date)
#'
#' ggplot(cpieth, aes(ethdt, cpi)) +
#'   geom_line() +
#'   scale_x_ethdate(breaks = eth_breaks(6),
#'                   labels = eth_labels("%Y"),
#'                   name = "Year (EC)") +
#'   theme_bw()


scale_x_ethdate <- function(breaks = eth_breaks(),
                            labels = eth_labels(),
                            ...) {
  ggplot2::scale_x_continuous(
    breaks = breaks,
    labels = labels,
    ...
  )
}

#' @export
#' @rdname ethdate-ggplot
scale_y_ethdate <- function(breaks = eth_breaks(),
                            labels = eth_labels(),
                            ...) {
  ggplot2::scale_y_continuous(
    breaks = breaks,
    labels = labels,
    ...
  )
}

#' @export
#' @rdname ethdate-ggplot
eth_breaks <- function(n = 5, pretty = TRUE) {
  function(x) {
    if (pretty) {
      x_data <- vctrs::vec_data(x)
      rng <- range(x_data, na.rm = TRUE)
      breaks <- pretty(rng, n = n)
      eth_date(breaks)
    } else {
      min_val <- min(x, na.rm = TRUE)
      max_val <- max(x, na.rm = TRUE)
      breaks <- seq(min_val, max_val, length.out = n)
      eth_date(unique(breaks))
    }
  }
}

#' @export
#' @rdname ethdate-ggplot
eth_labels <- function(format = "%b %d, %Y", lang = "lat") {
  function(x) {
    format(eth_date(x), format = format, lang = lang)
  }
}


#' @exportS3Method scales::rescale
rescale.ethdate <- function(x, to = c(0, 1), from = range(x, na.rm = TRUE, finite = TRUE), ...) {
  x_numeric <- vctrs::vec_data(x)
  scales::rescale(x_numeric, to = to, from = unclass(from), ...)
}



## ---- Register scale type ---------
#' @exportS3Method ggplot2::scale_type
scale_type.ethdate <- function(x) c("ethdate", "continuous")


#' @exportS3Method ggplot2::scale_type
scale_type.ethdifftime <- function(x) "continuous"

