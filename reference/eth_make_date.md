# Make Ethiopian Date

Make Ethiopian date from year, month and day components.

## Usage

``` r
eth_make_date(year, month, day)
```

## Arguments

- year:

  an integer vector of Ethiopian year.

- month:

  an integer vector of Ethiopian month.

- day:

  an integer vector of Ethiopian day.

## Value

a vector of an 'ethdate' object.

## Details

This function makes an Ethiopian date object from three integer vectors
of an equal length. It validates the date and returns `NA` for invalid
dates. It accounts for leap years.

## See also

[`eth_date()`](https://guturago.github.io/ethiodate/reference/eth_date.md)
[`eth_parse_date()`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md)

## Author

Gutama Girja Urago

## Examples

``` r
eth_make_date(2017, 01, 15)
#> [1] "2017-01-15"
```
