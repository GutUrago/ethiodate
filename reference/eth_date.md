# Create an Ethiopian Date Object

Convert an object to an Ethiopian date.

## Usage

``` r
eth_date(x, ...)

# Default S3 method
eth_date(x, ...)

# S3 method for class 'numeric'
eth_date(x, origin, ...)

# S3 method for class 'character'
eth_date(x, format = "%Y-%m-%d", lang = c("lat", "amh", "en"), ...)

# S3 method for class 'Date'
eth_date(x, ...)

# S3 method for class 'POSIXct'
eth_date(x, ...)

# S3 method for class 'POSIXt'
eth_date(x, ...)

# S3 method for class 'factor'
eth_date(x, ...)
```

## Arguments

- x:

  a numeric, character, Date, POSIXct or POSIXt vector.

- ...:

  further arguments to be passed to specific methods (see above).

- origin:

  a ethdate, Date object, or something that can be coerced by
  `eth_date(origin, ...)`. Default: the Unix epoch of "1970-01-01" GC
  ("1962-04-23" EC).

- format:

  format argument for character method to parse the date.

- lang:

  a language in which month names are written, if included in x. Use
  "lat" for Amharic month names written in Latin alphabets, "amh" for
  month names written in Amharic alphabets, and "en" for English month
  names.

## Value

a vector of an 'ethdate' object corresponding to x.

## Details

`eth_date()` internally stores the number of days as double since the
Unix epoch of "1970-01-01" GC ("1962-04-23" EC). Days before
"1962-04-23" EC are represented as negative numbers. This makes it easy
to convert from and to base `Date` objects.

The conversion of numeric vectors assumes that the vector represents a
number of days since the origin ("1962-04-23" EC if origin is NULL). For
the date objects, it extracts underlying numeric values and convert it
to an `ethiodate` object. To convert from POSIXct or POSIXt, it coerces
these objects to base Date objects and then applies the conversion.

To parse a character vector, a valid format must be supplied. The
default is "%Y-%m-%d". Please see the details section of
[`strptime`](https://rdrr.io/r/base/strptime.html). Factors can also be
coerced to `ethdate` after being internally converted to character.

## See also

[`eth_make_date()`](https://guturago.github.io/ethiodate/reference/eth_make_date.md)
[`eth_parse_date()`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md)

## Author

Gutama Girja Urago

## Examples

``` r
eth_date(Sys.Date())
#> [1] "2018-04-09"
eth_date(Sys.time())
#> [1] "2018-04-09"

x <- 7
eth_date(x)
#> [1] "1962-04-30"
eth_date(x, origin = Sys.Date())
#> [1] "2018-04-16"
eth_date(x, origin = eth_today())
#> [1] "2018-04-16"
eth_date(x, origin = "2017-01-01")
#> [1] "2017-01-08"
eth_date(x, origin = "01-01-2017", format = "%d-%m-%Y")
#> [1] "2017-01-08"

s <- c("01/01/2013", "06/13/2011")
eth_date(s, format = "%d/%m/%Y")
#> [1] "2013-01-01" "2011-13-06"


```
