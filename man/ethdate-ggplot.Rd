% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggplot.R
\name{ethdate-ggplot}
\alias{ethdate-ggplot}
\alias{scale_x_ethdate}
\alias{scale_y_ethdate}
\alias{eth_breaks}
\alias{eth_labels}
\title{Plotting Ethiopian Date}
\usage{
scale_x_ethdate(breaks = eth_breaks(), labels = eth_labels(), ...)

scale_y_ethdate(breaks = eth_breaks(), labels = eth_labels(), ...)

eth_breaks(n = 5, pretty = TRUE)

eth_labels(format = "\%b \%d, \%Y", lang = "lat")
}
\arguments{
\item{breaks}{A numeric vector of positions or \code{eth_breaks()} function.}

\item{labels}{A character vector giving labels (must be same length as breaks) or
\code{eth_labels()} function.}

\item{...}{further arguments to be passed to \code{\link[ggplot2:scale_continuous]{ggplot2::scale_x_continuous()}} or \code{\link[ggplot2:scale_continuous]{ggplot2::scale_y_continuous()}}.}

\item{n}{A number of breaks.}

\item{pretty}{Logical; if TRUE, use pretty() for rounded breaks.}

\item{format}{A format for the \code{ethdate}.}

\item{lang}{A language for the month or weekday names if involved. Use "lat" for Latin alphabets
"amh" for Amharic alphabets, and "en" for English names.}
}
\value{
Maps \code{ethdate} objects on \code{ggplot2} layers.
}
\description{
Helper functions to plot an \code{ethdate} object using \code{ggplot2}.
}
\details{
\code{eth_labels()} and \code{eth_breaks()} are designed to be used only in the \verb{scale_(x|y)_ethdate} functions.
}
\examples{

library(ggplot2)

cpieth[["ethdt"]] <- eth_date(cpieth$date)

ggplot(cpieth, aes(ethdt, cpi)) +
  geom_line() +
  scale_x_ethdate(breaks = eth_breaks(6),
                  labels = eth_labels("\%Y"),
                  name = "Year (EC)") +
  theme_bw()
}
\author{
Gutama Girja Urago
}
