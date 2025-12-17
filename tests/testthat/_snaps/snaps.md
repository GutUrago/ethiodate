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
      Error in `get_component()`:
      x The input `x` must be <ethdate>.
      i Current type of `x` is <numeric>.
      i Please use the constructor function `as_ethdate()` to create the object.

---

    Code
      eth_month(0)
    Condition
      Error in `get_component()`:
      x The input `x` must be <ethdate>.
      i Current type of `x` is <numeric>.
      i Please use the constructor function `as_ethdate()` to create the object.

---

    Code
      eth_monthname(0)
    Condition
      Error in `eth_monthname()`:
      x The input `x` must be <ethdate>.
      i Current type of `x` is <numeric>.

---

    Code
      eth_weekday(0)
    Condition
      Error in `eth_weekday()`:
      x The input `x` must be <ethdate>.
      i Current type of `x` is <numeric>.

---

    Code
      eth_day(0)
    Condition
      Error in `get_component()`:
      x The input `x` must be <ethdate>.
      i Current type of `x` is <numeric>.
      i Please use the constructor function `as_ethdate()` to create the object.

# Ops error testing

    Code
      eth_date(0) + eth_date(0)
    Condition
      Error in `vec_arith()`:
      ! <ethdate> + <ethdate> is not permitted

---

    Code
      1 - eth_date(0)
    Condition
      Error in `vec_arith()`:
      ! <double> - <ethdate> is not permitted

# Formattig test

    Code
      format(eth_date(0), format = "The origin is %B (%b) %m %A (%a) %d, %Y (%y)")
    Output
      [1] "The origin is Tahsas (Tah) 04 Hamus (Ham) 23, 1962 (62)"

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

---

    Code
      format(eth_date(2), format = 2)
    Condition
      Error in `format()`:
      ! Format must be <character>, not <numeric>.

# Printing test

    Code
      print(eth_date(1:5))
    Output
      [1] "1962-04-24" "1962-04-25" "1962-04-26" "1962-04-27" "1962-04-28"

---

    Code
      print(eth_date(1:5) - eth_date(1))
    Output
      Time differences in days
      [1] 0 1 2 3 4

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
      Time differences in days
      [1] 0 1 2
       [ reached 'max' / getOption("max.print") -- omitted 2 entries ]

---

    Code
      print(eth_date(NULL))
    Output
      ethdate of length 0

# Format = %Blang = amh

    Code
      eth_show(x, lang)
    Output
            1       2       3       4       5       6       7       8       9      10 
      "መስከረም"  "ጥቅምት"   "ህዳር"  "ታህሳስ"    "ጥር"  "የካቲት"  "መጋቢት"  "ሚያዝያ"  "ግንቦት"    "ሰኔ" 
           11      12      13 
        "ሐምሌ"   "ነሐሴ"   "ጳጉሜ" 

# Format = %Blang = lat

    Code
      eth_show(x, lang)
    Output
               1          2          3          4          5          6          7 
      "Meskerem"   "Tikimt"    "Hidar"   "Tahsas"      "Tir"  "Yekatit"  "Megabit" 
               8          9         10         11         12         13 
       "Miyazya"   "Ginbot"     "Sene"    "Hamle"   "Nehase"   "Pagume" 

# Format = %Blang = en

    Code
      eth_show(x, lang)
    Output
                1           2           3           4           5           6 
      "September"   "October"  "November"  "December"   "January"  "February" 
                7           8           9          10          11          12 
          "March"     "April"       "May"      "June"      "July"    "August" 
               13 
         "Pagume" 

# Format = %blang = amh

    Code
      eth_show(x, lang)
    Output
         1    2    3    4    5    6    7    8    9   10   11   12   13 
      "መስ" "ጥቅ" "ህዳ" "ታህ" "ጥር" "የካ" "መጋ" "ሚያ" "ግን" "ሰኔ" "ሐም" "ነሐ" "ጳጉ" 

# Format = %blang = lat

    Code
      eth_show(x, lang)
    Output
           1      2      3      4      5      6      7      8      9     10     11 
      "Mesk"  "Tik"  "Hid"  "Tah"  "Tir"  "Yek"  "Meg"  "Miy"  "Gin"  "Sen"  "Ham" 
          12     13 
       "Neh"  "Pag" 

# Format = %blang = en

    Code
      eth_show(x, lang)
    Output
          1     2     3     4     5     6     7     8     9    10    11    12    13 
      "Sep" "Oct" "Nov" "Dec" "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Pag" 

# Format = %Alang = amh

    Code
      eth_show(x, lang)
    Output
           1      2      3      4      5      6      7 
        "ሰኞ" "ማክሰኞ"  "ረቡዕ"  "ሐሙስ"  "ዓርብ"  "ቅዳሜ"  "እሁድ" 

# Format = %Alang = lat

    Code
      eth_show(x, lang)
    Output
               1          2          3          4          5          6          7 
         "Segno" "Maksegno"     "Rebu"    "Hamus"      "Arb"   "Kidame"     "Ehud" 

# Format = %Alang = en

    Code
      eth_show(x, lang)
    Output
                1           2           3           4           5           6 
         "Monday"   "Tuesday" "Wednesday"  "Thursday"    "Friday"  "Saturday" 
                7 
         "Sunday" 

# Format = %alang = amh

    Code
      eth_show(x, lang)
    Output
         1    2    3    4    5    6    7 
      "ሰኞ" "ማክ" "ረቡ" "ሐሙ" "ዓር" "ቅዳ" "እሁ" 

# Format = %alang = lat

    Code
      eth_show(x, lang)
    Output
          1     2     3     4     5     6     7 
      "Seg" "Mak" "Reb" "Ham" "Arb" "Kid" "Ehu" 

# Format = %alang = en

    Code
      eth_show(x, lang)
    Output
          1     2     3     4     5     6     7 
      "Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun" 

# Wrong component error

    Code
      get_component(2, "invalid")
    Condition
      Error in `get_component()`:
      x Invalid component "invalid".
      i The input `component` must be one of: year, month, day, td, wx.

---

    Code
      eth_make_date("2019", 2, 8)
    Condition
      Error in `eth_make_date()`:
      ! All arguments must be <numeric>.
      x Got types - year: <character>, month: <numeric>, day: <numeric>.

# Print.ethdifftime

    Code
      new_ethdifftime(NULL)
    Output
      ethdifftime of length 0

---

    Code
      new_ethdifftime(1)
    Output
      Time difference of 1 days

