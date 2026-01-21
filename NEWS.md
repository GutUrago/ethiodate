# ethiodate 0.3.1

Fix summary.ethdate() and its tests to be robust to R >= 4.6.0

# ethiodate 0.3.0

* `eth_monthname()` now accepts numeric months as input.
* Introduced recycling vector lengths to support different formats and origins.
* Switched internal data storage from integer to double for better precision.

# ethiodate 0.2.1

* Enhanced error messages with `cli` to make it more informative and user-friendly.

# ethiodate 0.2.0

## New Features

* Added `scale_x_ethdate()` and `scale_y_ethdate()`
* Added `eth_breaks()` and `eth_labels()`
* Added `eth_quarter()`

## Enhancement

* Defined `seq()` and `cut()` for `ethdate` class. 


# ethiodate 0.1.0

* Initial.
