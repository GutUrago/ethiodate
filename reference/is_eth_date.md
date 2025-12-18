# Utils

Small helper functions.

## Usage

``` r
# S3 method for class 'ethdate'
format(x, format = "%Y-%m-%d", lang = c("lat", "amh", "en"), ...)

is_eth_date(x)

is_eth_leap(x)

# S3 method for class 'ethdate'
as.Date(x, ...)

# S3 method for class 'ethdate'
as.double(x, ...)

# S3 method for class 'ethdate'
as.integer(x, ...)

# S3 method for class 'ethdate'
as.character(x, ...)
```

## Arguments

- x:

  an ethdate or numeric vector.

- format:

  a format for character date.

- lang:

  a language.

- ...:

  further arguments to be passed to specific methods.

## Value

`is_eth_leap()` returns a boolean vector,
[`as.Date()`](https://rdrr.io/r/base/as.Date.html) returns a Date
object, [`as.numeric()`](https://rdrr.io/r/base/numeric.html) returns
number of date since 1970-01-01 GC (1962-04-23 EC), and
[`as.character()`](https://rdrr.io/r/base/character.html) returns
formatted character date.

## Examples

``` r
is_eth_leap(2011)
#> [1] TRUE
```
