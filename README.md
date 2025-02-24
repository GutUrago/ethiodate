
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ethDate

<!-- badges: start -->

[![R-CMD-check](https://github.com/GutUrago/ethDate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GutUrago/ethDate/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/GutUrago/ethDate/graph/badge.svg)](https://app.codecov.io/gh/GutUrago/ethDate)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

This package provides a robust and efficient solution for converting
between Ethiopian and Gregorian dates. Built with high-performance C++
code via `{Rcpp}`, it ensures lightning-fast computations. It has
built-in checks for leap years and 13th month (Pagume).

## Key Features:

- **Seamless Date Conversion:** Effortlessly convert Ethiopian dates to
  and from Gregorian dates.
- **High-Speed Computation:** Optimized with {Rcpp} for maximum
  efficiency.
- **Date Arithmetic:** Perform date additions and subtractions with
  precision.
- **Day-Based Units:** Dates are represented as the number of days since
  a defined base date (1970-01-01).

🚀 **Upcoming Features:** Future versions will extend support for time
and time zones.

## Installation

You can install the development version of ethDate like so:

``` r
# install.packages("devtools")
devtools::install_github("GutUrago/ethDate")
```

## Base Date

The default `base` package origin is ‘1970-01-01’ and `ethDate` does the
same with equivalent Ethiopian date.

``` r
as.Date(0)
#> [1] "1970-01-01"
```

``` r
library(ethDate)
as_eth_date(0)
#> [1] "1962-04-23"
#> attr(,"class")
#> [1] "ethDate"
```

You can convert `ethDate` object to Gregorian calendar to get equivalent
date. For the above example we can do:

``` r
to_gregorian(as_eth_date(0))
#> [1] "1970-01-01"
```

``` r
to_ethiopian(as.Date(0))
#> [1] "1962-04-23"
#> attr(,"class")
#> [1] "ethDate"
```

## Parse Ethiopian Dates

Ethiopian dates can be parsed from integers (number of days since
1970-01-01), character, and of course, Gregorian dates.

1.  **Integers**

Use negative integers to represent date before the base date.

``` r
as_eth_date(20000)
#> [1] "2017-01-24"
#> attr(,"class")
#> [1] "ethDate"
```

``` r
as_eth_date(-20000)
#> [1] "1907-07-22"
#> attr(,"class")
#> [1] "ethDate"
```

2.  **Character**

``` r
as_eth_date("2017-06-13")
#> [1] "2017-06-13"
#> attr(,"class")
#> [1] "ethDate"
```

``` r
as_eth_date("2010/07/13", sep = "/")
#> [1] "2010-07-13"
#> attr(,"class")
#> [1] "ethDate"
```

``` r
as_eth_date("06/13/2011", sep = "/", orders = "dmy")
#> [1] "2011-13-06"
#> attr(,"class")
#> [1] "ethDate"
```

3.  **Date**

``` r
as_eth_date(as.Date("2025-01-01"))
#> [1] "2017-04-23"
#> attr(,"class")
#> [1] "ethDate"
```

## Date Arithmetic

You can add or subtract scalar date to and from the `ethDate` object.
The scalar represent number of days.

``` r
date_1 <- as_eth_date("2017-01-01")
date_1 + 30
#> [1] "2017-02-01"
#> attr(,"class")
#> [1] "ethDate"
date_1 + 365
#> [1] "2018-01-01"
#> attr(,"class")
#> [1] "ethDate"
date_1 + 7
#> [1] "2017-01-08"
#> attr(,"class")
#> [1] "ethDate"
date_1 - 7
#> [1] "2016-12-29"
#> attr(,"class")
#> [1] "ethDate"
date_1 - 366
#> [1] "2015-13-06"
#> attr(,"class")
#> [1] "ethDate"
```

## Example

In this example, we use `lakers` data from `lubridate` package and
convert dates back and forth two times to check it’s consistency.

``` r
library(tidyverse)

df <- lakers |> 
  mutate(date_gre = ymd(date),
         date_eth = as_eth_date(date_gre),
         date_gre2 = to_gregorian(date_eth),
         date_eth2 = to_ethiopian(date_gre2)) |> 
  select(starts_with("date"))


kableExtra::kable(head(df))
```

|     date | date_gre   | date_eth   | date_gre2  | date_eth2  |
|---------:|:-----------|:-----------|:-----------|:-----------|
| 20081028 | 2008-10-28 | 2001-02-18 | 2008-10-28 | 2001-02-18 |
| 20081028 | 2008-10-28 | 2001-02-18 | 2008-10-28 | 2001-02-18 |
| 20081028 | 2008-10-28 | 2001-02-18 | 2008-10-28 | 2001-02-18 |
| 20081028 | 2008-10-28 | 2001-02-18 | 2008-10-28 | 2001-02-18 |
| 20081028 | 2008-10-28 | 2001-02-18 | 2008-10-28 | 2001-02-18 |
| 20081028 | 2008-10-28 | 2001-02-18 | 2008-10-28 | 2001-02-18 |

Let’s confirm it’s consistency:

``` r
all(df$date_gre == df$date_gre2)
#> [1] TRUE
```

``` r
all(df$date_eth == df$date_eth2)
#> [1] TRUE
```

<div>
<h1 style="text-align: center; color=steelblue">The End!</h1>
</div>
