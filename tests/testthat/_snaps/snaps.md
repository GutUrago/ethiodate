# eth_components works only on ethDate

    Code
      eth_year(0)
    Condition
      Error in `eth_year()`:
      ! `x` must be an Ethiopian date object.

---

    Code
      eth_month(0)
    Condition
      Error in `eth_month()`:
      ! `x` must be an Ethiopian date object.

---

    Code
      eth_monthname(0)
    Condition
      Error in `eth_monthname()`:
      ! `x` must be an Ethiopian date object.

---

    Code
      eth_weekday(0)
    Condition
      Error in `eth_weekday()`:
      ! `x` must be an Ethiopian date object.

---

    Code
      eth_day(0)
    Condition
      Error in `eth_day()`:
      ! `x` must be an Ethiopian date object.

# eth_make works only for numeric and equal length vectors

    Code
      eth_make_date(1960:1970, 1:10, 10:20)
    Condition
      Error:
      ! Year, month, and day must be integer vectors of the same length.

---

    Code
      eth_make_date(1960:1970, 1:11, rep("x", 11))
    Condition
      Error in `eth_make_date()`:
      ! Year, month, and day must be integer vectors.

# Ops error testing

    Code
      eth_date(0) + eth_date(0)
    Condition
      Error in `+.ethDate`:
      ! binary + is not defined for "ethDate" objects

---

    Code
      1 - eth_date(0)
    Condition
      Error in `-.ethDate`:
      ! can only subtract from "ethDate" objects

# Formattig test

    Code
      format(eth_date(0), format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)")
    Output
      [1] "The origin is ታህሳስ (ታህ) 04 ሐሙስ (ሐሙ) 23, 1962 (62)"

---

    Code
      format(eth_date(0), format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)",
      lang = "lat")
    Output
      [1] "The origin is Tahsas (Tah) 04 Hamus (Ham) 23, 1962 (62)"

---

    Code
      format(eth_date(0), format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)",
      lang = "en")
    Output
      [1] "The origin is December (Dec) 04 Thursday (Thu) 23, 1962 (62)"

# Printing test

    Code
      eth_date(1:17)
    Output
       [1] "1962-04-24" "1962-04-25" "1962-04-26" "1962-04-27" "1962-04-28"
       [6] "1962-04-29" "1962-04-30" "1962-05-01" "1962-05-02" "1962-05-03"
      [11] "1962-05-04" "1962-05-05" "1962-05-06" "1962-05-07" "1962-05-08"
      [16] "1962-05-09" "1962-05-10"

---

    Code
      eth_date(1:17) - eth_date(1)
    Output
       [1] "Time difference of 0 days " "Time difference of 1 days "
       [3] "Time difference of 2 days " "Time difference of 3 days "
       [5] "Time difference of 4 days " "Time difference of 5 days "
       [7] "Time difference of 6 days " "Time difference of 7 days "
       [9] "Time difference of 8 days " "Time difference of 9 days "
      [11] "Time difference of 10 days" "Time difference of 11 days"
      [13] "Time difference of 12 days" "Time difference of 13 days"
      [15] "Time difference of 14 days" "Time difference of 15 days"
      [17] "Time difference of 16 days"

