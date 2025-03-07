






#' Extract Components of Dates
#'
#' @param x a vector of class Ethiopian dates
#'
#' @returns An integer vector
#' @author Gutama Girja Urago
#'
#' @export
#'
#' @examples
#' if (FALSE) {
#' x <- as_eth_date("2017-01-01")
#' year <- eth_year(x)
#' month <- eth_month(x)
#' day <- eth_day(x)
#' weekday <- eth_weekday(x)
#' monthname <- eth_monthname(x)
#' }
eth_year <- function(x) {
  x <- eth_split(x)[["year"]]
  as.integer(x)
}


#' @export
#' @rdname eth_year
eth_month <- function(x) {
  x <- eth_split(x)[["month"]]
  as.integer(x)
}

#' @export
#' @rdname eth_year
eth_day <- function(x) {
  x <- eth_split(x)[["day"]]
  as.integer(x)
}

#' @export
#' @rdname eth_year
eth_weekday <- function(x) {
  x <- as_numeric(x)
  # 1970-01-01 was on Thursday
  weekday_names <- c("ሐሙስ", "ዓርብ", "ቅዳሜ", "እሁድ", "ሰኞ", "ማክሰኞ", "ረቡዕ")
  weekday_number <- (x) %% 7
  weekday_names[weekday_number + 1]
}

#' @export
#' @rdname eth_year
eth_monthname <- function(x) {
  x <- eth_month(x)
  month_names <- c("መስከረም", "ጥቅምት", "ኅዳር", "ታኅሳስ", "ጥር", "የካቲት",
                   "መጋቢት", "ሚያዝያ", "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጉሜ")
  month_names[x]
}



# Split date components
eth_split <- function(x) {
  checkmate::assert_class(x, "ethDate")
  year <- substr(x, 0, 4)
  month <- substr(x, 6, 7)
  day <- substr(x, 9, 10)
  return(
    list(
      year = year,
      month = month,
      day = day
    )
  )
}


