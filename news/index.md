# Changelog

## ethiodate 0.3.1

CRAN release: 2026-01-21

Fix summary.ethdate() and its tests to be robust to R \>= 4.6.0

## ethiodate 0.3.0

CRAN release: 2025-12-19

- [`eth_monthname()`](https://guturago.github.io/ethiodate/reference/eth_year.md)
  now accepts numeric months as input.
- Introduced recycling vector lengths to support different formats and
  origins.
- Switched internal data storage from integer to double for better
  precision.

## ethiodate 0.2.1

- Enhanced error messages with `cli` to make it more informative and
  user-friendly.

## ethiodate 0.2.0

CRAN release: 2025-05-28

### New Features

- Added
  [`scale_x_ethdate()`](https://guturago.github.io/ethiodate/reference/ethdate-ggplot.md)
  and
  [`scale_y_ethdate()`](https://guturago.github.io/ethiodate/reference/ethdate-ggplot.md)
- Added
  [`eth_breaks()`](https://guturago.github.io/ethiodate/reference/ethdate-ggplot.md)
  and
  [`eth_labels()`](https://guturago.github.io/ethiodate/reference/ethdate-ggplot.md)
- Added
  [`eth_quarter()`](https://guturago.github.io/ethiodate/reference/eth_year.md)

### Enhancement

- Defined [`seq()`](https://rdrr.io/r/base/seq.html) and
  [`cut()`](https://rdrr.io/r/base/cut.html) for `ethdate` class.

## ethiodate 0.1.0

CRAN release: 2025-05-15

- Initial.
