
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ethiodate

<!-- badges: start -->

[![R-CMD-check](https://github.com/GutUrago/ethiodate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GutUrago/ethiodate/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/GutUrago/ethiodate/graph/badge.svg)](https://app.codecov.io/gh/GutUrago/ethiodate)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

This package provides a robust and efficient solution for working with
Ethiopian dates. It can seamlessly convert to and from Gregorian dates.
It ensures lightning-fast computations thanks to the `{Rcpp}` package
that enables the integration of high-performance C++ code. It has
built-in checks for leap years and the 13th month (Pagume).

## Key Features:

- **Seamless Date Conversion:** Effortlessly convert Ethiopian dates to
  and from Gregorian dates.
- **High-Speed Computation:** Optimized with {Rcpp} for maximum
  efficiency.
- **Date Arithmetic:** Perform date additions and subtractions with
  precision.
- **Day-Based Units:** Dates are represented as the number of days since
  1963-04-23 EC (1970-01-01 GC).

🚀 **Upcoming Features:** Future versions will extend support for time
and time zones.

## Installation

You can install the development version of `ethiodate` package like so:

``` r
# install.packages("devtools")
devtools::install_github("GutUrago/ethiodate")
```

## Origin Date

The default `base` package origin date is ‘1970-01-01 GC’ and
`ethiodate` does the same with equivalent Ethiopian date, which is
‘1962-04-23 EC’. Both base `Date` object and `ethdate` internally stores
number of days since origin date. The days before the origin date are
represented with negative values. This makes computation easier.

``` r
# The same origin as 'Date' object
library(ethiodate)
as.Date(0) == vctrs::vec_data(eth_date(0))
#> [1] TRUE

as.Date(0)
#> [1] "1970-01-01"
eth_date(0)
#> [1] "1962-04-23"
```

You can convert `ethdate` object to Gregorian calendar to get equivalent
date. For the above example we can do:

``` r
as.Date(eth_date(0))
#> [1] "1970-01-01"
```

``` r
eth_date(as.Date(0))
#> [1] "1962-04-23"
```

## Parsing

Ethiopian dates can be parsed from integers (number of days since
1962-04-23 EC / 1970-01-01 GC), separate vector of year components, and
of course, Gregorian dates.

1.  **Integers**

Use negative integers to represent date before the origin date.

``` r
eth_date(20000)
#> [1] "2017-01-24"
```

``` r
eth_date(-20000)
#> [1] "1907-07-22"
```

2.  **Year components**

``` r
eth_make_date(2017, 01, 01)
#> [1] "2017-01-01"
```

3.  **Date**

``` r
eth_date(as.Date("2025-01-01"))
#> [1] "2017-04-23"
```

## Date Arithmetic

You can add or subtract scalar date to and from the `ethDate` object.
The scalar represent number of days.

``` r
date_1 <- eth_make_date(2017,01,01)
date_1 + 400
#> [1] "2018-02-06"
date_1 - 1
#> [1] "2016-13-05"
```

You can subtract date object as well.

``` r
eth_make_date(2017, 01, 25) - eth_make_date(2017, 01, 10)
#> [1] "Time difference of 15 days"

eth_date(0) - eth_date(as.Date("1970-01-01"))
#> [1] "Time difference of 0 days"
```

## Formatting

You can nicely format Ethiopian dates like you do with base `Date`
object. This makes it easy to use with inline code for reports and
exporting files.

``` r
x <- eth_make_date(2000, 1, 15)
format(x, format = "%B %d, %Y")
#> [1] "መስከረም 15, 2000"
```

``` r
format(x, format = "%B %d, %Y", lang = "lat")
#> [1] "Meskerem 15, 2000"
```

``` r
format(eth_date(Sys.Date()), format = "This file was updated on %B %d, %Y EC.", lang = "en")
#> [1] "This file was updated on March 17, 2017 EC."
```

## Example

In this example, we use `lakers` data from `lubridate` package and
convert dates back and forth two times to check it’s consistency.

``` r
library(tidyverse)

df <- lakers |> 
  mutate(date_gre = ymd(date),
         date_eth = eth_date(date_gre),
         date_gre2 = as.Date(date_eth),
         date_eth2 = eth_date(date_gre2)) |> 
  select(starts_with("date"))


kableExtra::kable(sample_n(df, 5))
```

|     date | date_gre   |   date_eth | date_gre2  |  date_eth2 |
|---------:|:-----------|-----------:|:-----------|-----------:|
| 20081223 | 2008-12-23 | 2001-04-14 | 2008-12-23 | 2001-04-14 |
| 20090109 | 2009-01-09 | 2001-05-01 | 2009-01-09 | 2001-05-01 |
| 20081203 | 2008-12-03 | 2001-03-24 | 2008-12-03 | 2001-03-24 |
| 20090204 | 2009-02-04 | 2001-05-27 | 2009-02-04 | 2001-05-27 |
| 20081109 | 2008-11-09 | 2001-02-30 | 2008-11-09 | 2001-02-30 |

Let’s confirm it’s consistency:

``` r
all(df$date_gre == df$date_gre2)
#> [1] TRUE
```

``` r
all(df$date_eth == df$date_eth2)
#> [1] TRUE
```

That proves it consistently converted dates back and forth for all
**34624** observations in the `lakers` dataset.

<div>
<h1 style="text-align: center; color=blue">The End!</h1>
</div>
