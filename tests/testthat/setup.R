
# Data setup for tests ----
library(dplyr, quietly = TRUE)

set.seed(123)

df <- tibble(x = -100000:100000) |>
  mutate(
    .row = row_number(),
    bad = .row %in% sample.int(n(), size = floor(0.04 * n())),
    x = if_else(
      bad,
      sample(c(NA_real_, NaN, Inf, -Inf), n(), replace = TRUE),
      x
    )
  ) |>
  select(x) |>
  mutate(
    # Gregorian / Ethiopian base
    gre_d = as.Date(x),
    eth_d = eth_date(x),

    gre_x = as.numeric(gre_d),
    eth_x = as.numeric(eth_d),

    # Date arithmetic
    gre_add_7 = gre_d + 7,
    gre_sub_7 = gre_d - 7,
    eth_add_7 = eth_d + 7,
    eth_sub_7 = eth_d - 7,

    # Leap years
    eth_leap = is_eth_leap(eth_d),

    gre_year = as.POSIXlt(gre_d)$year + 1900,
    gre_leap = gre_year %% 4 == 0 &
      (gre_year %% 100 != 0 | gre_year %% 400 == 0),

    # Ethiopian components
    eth_y = eth_year(eth_d),
    eth_m = eth_month(eth_d),
    eth_d1 = eth_day(eth_d),

    eth_new_d = suppressWarnings(eth_make_date(eth_y, eth_m, eth_d1)),

    # Coercions
    eth_as_date = as.Date(eth_d),
    eth_from_gre = eth_date(gre_d),

    posix_1 = as.POSIXct(gre_d),
    posix_2 = as.POSIXlt(gre_d),

    eth_from_1 = eth_date(posix_1),
    eth_from_2 = eth_date(posix_2)
  ) %>%
  select(-gre_year)

