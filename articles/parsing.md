# Parse Ethiopian Dates

## Parsing Ethiopian Dates

Parsing involves converting an external representation of a date (like
text) into an internal `ethdate` object that R can understand and
manipulate. ethiodate offers robust methods for parsing dates from
character strings and numeric values.

### From Character Strings

he most common scenario involves parsing dates provided as text. The
[`eth_parse_date()`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md)
function is the primary tool for this task. It can handle standard date
formats, such as “YYYY-MM-DD”, assuming they represent dates in the
Ethiopian calendar.

``` r
library(ethiodate)
# Parse a single date string
eth_parse_date("2015-01-01")
#> [1] "2015-01-01"
```

[`eth_parse_date()`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md)
is vectorized, allowing you to parse multiple date strings in a single
call. This enables you use it in a
[tidyverse](https://tidyverse.tidyverse.org) data manipulation
pipelines.

``` r
# Parse a vector of date strings
eth_dates <- c("2015-01-01", "2015-02-15", "2015-13-05")
eth_parse_date(eth_dates)
#> [1] "2015-01-01" "2015-02-15" "2015-13-05"
```

#### Specifying Formats

Often, dates are not in the standard “YYYY-MM-DD” format. In such cases,
you must provide a format argument to
[`eth_parse_date()`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md)
that precisely matches the structure of your date strings. The format
argument uses a syntax similar to R’s base
[`strptime()`](https://rdrr.io/r/base/strptime.html) function. You can
consult its documentation
([`?strptime`](https://rdrr.io/r/base/strptime.html)) for a full list of
available format codes.

***Examples***

``` r
# Parsing dates in MM/DD/YYYY format
x <- c("01/17/2017", "05/12/2017")
eth_parse_date(x, format = "%m/%d/%Y")
#> [1] "2017-01-17" "2017-05-12"
```

#### Parsing with Month Names

ethiodate also supports parsing dates that include month names, both in
English and Amharic. The `lang` argument allows you to specify the
language of the month names.

- `%B`: Full month name.
- `%b`: Abbreviated month name.

``` r
# Using full English month names
eth_parse_date("Meskerem 25, 2017", format = "%B %d, %Y")
#> [1] "2017-01-25"

# Using full Amharic month names
eth_parse_date("መስከረም 25, 2017", format = "%B %d, %Y", lang = "amh")
#> [1] "2017-01-25"

# Using abbreviated English month names
eth_parse_date("Sep 25, 2017", format = "%b %d, %Y", lang = "en")
#> [1] "2017-01-25"
```

***Note:*** Ensure the format string exactly matches the pattern of your
date strings for successful parsing. Any discrepancy can lead to `NA`
values

### From Numeric Values

Internally, an `ethdate` object is represented as a numeric vector. This
vector stores the number of days elapsed since the standard ‘Unix epoch’
origin used in R, which is 1970-01-01 in the Gregorian Calendar (GC).
This corresponds to 1962-04-23 in the Ethiopian Calendar (EC). Dates
preceding this origin are represented by negative numbers. This
underlying numeric nature allows `ethdate` objects to integrate smoothly
with R’s base Date class and its functionalities.

``` r
# Show the numeric representation of an Ethiopian date
eth_parse_date("1962-04-23") |> unclass()
#> [1] 0

# Show the numeric representation of the Gregorian origin
as.Date("1970-01-01") |> unclass()
#> [1] 0
```

You can construct an `ethdate` object directly from numeric values using
the
[`eth_date()`](https://guturago.github.io/ethiodate/reference/eth_date.md)
function. If you provide a numeric vector, you can specify a custom
origin date. If no origin is provided, it defaults to the standard
1962-04-23 EC.

``` r
# Create an ethdate object 7 days after today
eth_date(7, origin = eth_today())
#> [1] "2018-04-16"

# Create an ethdate object 7 days before today
eth_date(-7, origin = eth_today())
#> [1] "2018-04-02"
```

### From Components

It is often convenient, especially during the field survey, to record
date components as separate vectors. ethiodate has a solution to create
an `ethdate` object from individual components: year, month, and day.
The
[`eth_make_date()`](https://guturago.github.io/ethiodate/reference/eth_make_date.md)
function facilitates this.

``` r
# Create a single date from components
eth_make_date(2017, 1, 1)
#> [1] "2017-01-01"

# Create multiple dates from component vectors
y <- c(2012, 2015)
m <- c(5, 9)
d <- c(15, 19)
eth_make_date(y, m, d)
#> [1] "2012-05-15" "2015-09-19"
```

## Handling Invalid and Missing Values

ethiodate performs validation during date creation and parsing. It
checks if the provided day, month, and year combinations are valid
within the Ethiopian calendar rules. For example, the 13th month,
Pagumē, only has 6 days during a leap year; otherwise, it has 5. If you
attempt to create an invalid date, ethiodate will return `NAs` and issue
a warning message, ensuring data integrity.

``` r
# 2011 is a leap year in EC, so Pagume 6 is valid
eth_date("2011-13-06")
#> [1] "2011-13-06"

# 2012 is not a leap year in EC, so Pagume 6 is invalid
eth_date("2012-13-06")
#> [1] NA

# Attempting to create a date with month 14
eth_make_date(2016, 14, 1)
#> [1] NA
```

Missing values (`NA`) in the input will result in `NA` in the output.

## Conversion

Seamless conversion between the Ethiopian and Gregorian calendars is a
core feature of ethiodate.

***To Ethiopian (`ethdate`)***

You can convert R’s standard `Date` objects (Gregorian) into `ethdate`
objects using
[`eth_date()`](https://guturago.github.io/ethiodate/reference/eth_date.md)
function.

``` r
# Convert a Gregorian date to Ethiopian
gre_date <- as.Date("2025-01-15")
eth_date(gre_date)
#> [1] "2017-05-07"
```

***To Gregorian (`Date`)***

Conversely, you can convert `ethdate` objects back to Gregorian Date
objects using R’s standard
[`as.Date()`](https://rdrr.io/r/base/as.Date.html) function.

``` r
# Convert an Ethiopian date (the origin) to Gregorian
eth_dt <- eth_date(0)
as.Date(eth_dt)
#> [1] "1970-01-01"
```

## Date Operations

`ethdate` objects support standard arithmetic operations, with the
fundamental unit being ‘days’. This allows for easy calculation of
durations and future/past dates.

``` r
# Add 6 days to a date
eth_date("2010-09-14") + 6
#> [1] "2010-09-20"

# Subtract 6 days from a date
eth_date("2010-09-14") - 6
#> [1] "2010-09-08"

# Calculate the difference between two dates (in days)
eth_date("2010-09-14") - eth_date("2010-09-10")
#> Time difference of 4 days
```

You can also perform comparisons:

``` r
ed1 <- eth_date("2010-09-14")
ed2 <- eth_date("2010-09-10")

ed1 > ed2
#> [1] TRUE

ed1 == ed2 + 4 
#> [1] TRUE
```

## Formatting

`ethdate` objects can be formatted into character strings using the
[`format()`](https://rdrr.io/r/base/format.html) function, similar to
R’s base `Date` objects. You can use standard `strptime` format codes to
customize the output.

``` r
# Format today's date in a custom string
format(eth_today(), format = "This document was updated on %B %d, %Y EC.")
#> [1] "This document was updated on Tahsas 09, 2018 EC."

# Format with day of the week and year
format(eth_today(), format = "Today is %A, %B %d, %Y.")
#> [1] "Today is Hamus, Tahsas 09, 2018."

# Format in Amharic
format(eth_today(), format = "%A، %B %d ቀን %Y ዓ.ም.", lang = "amh")
#> [1] "ሐሙስ، ታህሳስ 09 ቀን 2018 ዓ.ም."
```

## Conclusion

Working with Ethiopian calendar dates in R is made significantly easier
and more reliable with the ethiodate package. Its tools for parsing
diverse date formats, converting between calendar systems, performing
calculations, and formatting output provide a robust framework for
handling Ethiopian temporal data. By converting string or numeric inputs
into validated `ethdate` objects, ethiodate ensures that your
date-related analyses and operations are accurate and consistent.

For more detailed information on specific functions and advanced
features, please refer to the package’s help pages by running
[`?eth_date`](https://guturago.github.io/ethiodate/reference/eth_date.md),
[`?eth_parse_date`](https://guturago.github.io/ethiodate/reference/eth_parse_date.md),
[`?eth_make_date`](https://guturago.github.io/ethiodate/reference/eth_make_date.md),
and exploring the rest of the ethiodate documentation.
