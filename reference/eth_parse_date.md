# Parse Ethiopian Date

Parse Ethiopian date from character vector that has a non-digit
separator.

## Usage

``` r
eth_parse_date(x, format = "%Y-%m-%d", lang = c("lat", "amh", "en"))
```

## Arguments

- x:

  a character vector.

- format:

  a format in in which x is composed. See
  [`strptime`](https://rdrr.io/r/base/strptime.html).

- lang:

  a language in which month names are written, if included in x. Use
  "lat" for Amharic month names written in Latin alphabets, "amh" for
  month names written in Amharic alphabets, and "en" for English month
  names.

## Value

a vector of an'ethdate' object.

## Details

x must include a non-digit separator and exactly three components of the
date (year, month, and day).

## See also

[`eth_date()`](https://guturago.github.io/ethiodate/reference/eth_date.md)
[`eth_make_date()`](https://guturago.github.io/ethiodate/reference/eth_make_date.md)

## Author

Gutama Girja Urago

## Examples

``` r
eth_parse_date("2017-01-01")
#> [1] "2017-01-01"
s <- c("01/01/2013", "06/13/2011")
eth_parse_date(s, format = "%d/%m/%Y")
#> [1] "2013-01-01" "2011-13-06"
```
