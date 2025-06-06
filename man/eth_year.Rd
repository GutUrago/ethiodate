% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/date-components.R
\name{eth_year}
\alias{eth_year}
\alias{eth_month}
\alias{eth_monthname}
\alias{eth_day}
\alias{eth_weekday}
\alias{eth_quarter}
\title{Ethiopian Date Components}
\usage{
eth_year(x)

eth_month(x)

eth_monthname(x, lang = c("lat", "amh", "en"), abbreviate = FALSE)

eth_day(x)

eth_weekday(x, lang = c("lat", "amh", "en"), abbreviate = FALSE)

eth_quarter(x)
}
\arguments{
\item{x}{a vector of an Ethiopian date object}

\item{lang}{a language. 'lat' for Amharic written in Latin alphabets, 'amh' for Amharic, and
'en' for English}

\item{abbreviate}{Do you want to get an abbreviated month or weekday names?}
}
\value{
a vector
}
\description{
Small functions that helps to extract parts of Ethiopian date objects.
}
\examples{
today <- eth_date(Sys.Date())
eth_year(today)
eth_month(today)
eth_monthname(today)
eth_day(today)
eth_weekday(today)
}
\author{
Gutama Girja Urago
}
