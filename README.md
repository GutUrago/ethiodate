
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ethiodate <img src="man/figures/logo.png" align="right" height="138" alt="" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/GutUrago/ethiodate/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GutUrago/ethiodate/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/ethiodate)](https://cran.r-project.org/package=ethiodate)
[![cran
checks](https://badges.cranchecks.info/worst/ethiodate.svg)](https://cran.r-project.org/web/checks/check_results_ethiodate.html)
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.5.0-6666ff.svg)](https://cran.r-project.org/)
[![Codecov test
coverage](https://codecov.io/gh/GutUrago/ethiodate/graph/badge.svg)](https://app.codecov.io/gh/GutUrago/ethiodate)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![DOI](https://zenodo.org/badge/937977333.svg)](https://doi.org/10.5281/zenodo.15182197)

<!-- badges: end -->

This package enables you to work with Ethiopian dates in R like you do
with base R `Date` objects. It can seamlessly convert to and from
Gregorian dates, regardless of the way you record them. It supports
almost all important parsing techniques used for a base R Date object.
If you have ever worked with a `Date` object, you can do the same with
Ethiopian dates. It is designed to work smoothly with the `{tidyverse}`,
including `{ggplot2}`, `{dplyr}`, `{tibble}`, and `{lubridate}`, making
it ideal for data manipulation pipelines. This package ensures
lightning-fast computations thanks to the `{Rcpp}` package that enables
the integration of high-performance C++ code. It has built-in checks for
leap years and the 13th month (Pagume), which makes this package
crucial.

## Key Features:

- **Custom Date Object:** You can convert your date recorded in any
  style to custom `ethdate` object.
- **Seamless Date Conversion:** Effortlessly convert Ethiopian dates to
  and from Gregorian dates with precision.
- **High-Speed Computation:** Written in C++ for maximum efficiency.
- **Date Arithmetic:** Perform date arithmetic operations.
- **Day-Based Units:** Dates are represented as the number of days since
  1963-04-23 EC (1970-01-01 GC) to simplify conversion between
  calendars.
- **Integration with `{ggplot2}`:** Designed to smoothly work with
  `{ggplot2}`. <!--
  🚀 **Upcoming Features:** Future versions will extend support for time and time zones.
  -->

## Installation

You can install the development version of `ethiodate` package like so:

``` r
# Install the current version on CRAN
install.packages("ethiodate")

# Install a stable development version from GitHub (requires compilation)
devtools::install_github("GutUrago/ethiodate")
```

## Usage

This package is for you if you have ever faced the following conditions,
where;

- You recorded Ethiopian year, month and days as a separate variable and
  not sure if the combination is valid date.
- You recorded Ethiopian date as “dd-mm-yy”, “yy/mm/dd”, … etc, and you
  can’t perform any operations beyond string operations.
- You have Ethiopian dates in any of above listed format and want to
  convert it to Gregorian dates.
- You have Gregorian dates object and want to obtain equivalent
  Ethiopian dates.
- You want to do some arithmetic operations with Ethiopian dates.
- You want to build and present nicely formatted plots for time trends
  in local context.

**Examples:**

``` r
library(ethiodate)
library(dplyr)

data.frame(
  eth_year = c(2000, 2007, 2015, 2020, 1950, 2030),
  eth_month = c(8, 2, 13, 5, 7, 5),
  eth_day = c(25, 12, 6, 8, 17, 30)
) |> 
  mutate(
    eth_date = eth_make_date(eth_year, eth_month, eth_day),
    gre_date = as.Date(eth_date),
    eth_dayname = eth_weekday(eth_date, lang = "en"), 
    gre_dayname = weekdays(gre_date) 
  )
#>   eth_year eth_month eth_day   eth_date   gre_date eth_dayname gre_dayname
#> 1     2000         8      25 2000-08-25 2008-05-03    Saturday    Saturday
#> 2     2007         2      12 2007-02-12 2014-10-22   Wednesday   Wednesday
#> 3     2015        13       6 2015-13-06 2023-09-11      Monday      Monday
#> 4     2020         5       8 2020-05-08 2028-01-17      Monday      Monday
#> 5     1950         7      17 1950-07-17 1958-03-26   Wednesday   Wednesday
#> 6     2030         5      30 2030-05-30 2038-02-07      Sunday      Sunday
```
