# See Month or Day Names

Small functions that displays texts.

## Usage

``` r
eth_show(x = c("%B", "%b", "%A", "%a"), lang = c("lat", "amh", "en"))

eth_today(...)

eth_now(...)
```

## Arguments

- x:

  what you want to see.

- lang:

  language of the text.

- ...:

  arguments that passes to
  [`format()`](https://rdrr.io/r/base/format.html)

## Value

Except for
[`eth_date()`](https://guturago.github.io/ethiodate/reference/eth_date.md),
which returns an `ethdate` object, other functions return a character
vector.

## Details

`eth_show()` displays the underlying month and weekday names that is
used by
[`eth_parse_date()`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md).

## Author

Gutama Girja Urago

## Examples

``` r
eth_show()
#>          1          2          3          4          5          6          7 
#> "Meskerem"   "Tikimt"    "Hidar"   "Tahsas"      "Tir"  "Yekatit"  "Megabit" 
#>          8          9         10         11         12         13 
#>  "Miyazya"   "Ginbot"     "Sene"    "Hamle"   "Nehase"   "Pagume" 
eth_show("%A", "amh")
#>      1      2      3      4      5      6      7 
#>   "ሰኞ" "ማክሰኞ"  "ረቡዕ"  "ሐሙስ"  "ዓርብ"  "ቅዳሜ"  "እሁድ" 
eth_today()
#> [1] "2018-05-13"
eth_now()
#> [1] "2018-05-13 02:53:32 PM"
```
