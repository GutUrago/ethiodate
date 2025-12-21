# Ethiopian Date Components

Small functions that helps to extract parts of Ethiopian date objects.

## Usage

``` r
eth_year(x)

eth_month(x)

eth_monthname(x, lang = c("lat", "amh", "en"), abbreviate = FALSE)

eth_day(x)

eth_weekday(x, lang = c("lat", "amh", "en"), abbreviate = FALSE)

eth_quarter(x)
```

## Arguments

- x:

  a vector of an Ethiopian date object

- lang:

  a language. 'lat' for Amharic written in Latin alphabets, 'amh' for
  Amharic, and 'en' for English

- abbreviate:

  Do you want to get an abbreviated month or weekday names?

## Value

a vector

## Author

Gutama Girja Urago

## Examples

``` r
today <- eth_date(Sys.Date())
eth_year(today)
#> [1] 2018
eth_month(today)
#> [1] 4
eth_monthname(today)
#> [1] "Tahsas"
eth_day(today)
#> [1] 12
eth_weekday(today)
#> [1] "Ehud"
```
