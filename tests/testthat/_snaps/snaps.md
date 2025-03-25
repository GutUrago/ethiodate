# Summary works for NAs too

    Code
      summary(eth_date(0:10))
    Output
              Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
      "1962-04-23" "1962-04-25" "1962-04-28" "1962-04-28" "1962-04-30" "1962-05-03" 

---

    Code
      summary(eth_date(c(NA, 0:10, NA)))
    Output
              Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
      "1962-04-23" "1962-04-25" "1962-04-28" "1962-04-28" "1962-04-30" "1962-05-03" 
              NA's 
               "2" 

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
      Error in `+.ethdate`:
      ! binary + is not defined for "ethdate" objects

---

    Code
      1 - eth_date(0)
    Condition
      Error in `-.ethdate`:
      ! can only subtract from "ethdate" objects

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
      print(eth_date(1:5))
    Output
      [1] "1962-04-24" "1962-04-25" "1962-04-26" "1962-04-27" "1962-04-28"

---

    Code
      print(eth_date(1:5) - eth_date(1))
    Output
      [1] "Time difference of 0 days" "Time difference of 1 days"
      [3] "Time difference of 2 days" "Time difference of 3 days"
      [5] "Time difference of 4 days"

---

    Code
      print(eth_date(1:5), max = 3)
    Output
      [1] "1962-04-24" "1962-04-25" "1962-04-26"
       [ reached getOption("max.print") -- omitted 2 entries ]

---

    Code
      print(eth_date(1:5) - eth_date(1), max = 3)
    Output
      [1] "Time difference of 0 days" "Time difference of 1 days"
      [3] "Time difference of 2 days"
       [ reached getOption("max.print") -- omitted 2 entries ]

