

#' @exportS3Method base::format
format.ethDate <- function(x, format = "%Y-%m-%d") {
  num_day <- as_numeric(x)
  x <- eth_split(x)
  eth_year <- as.integer(x[['year']])
  eth_month <- as.integer(x[['month']])
  eth_day <- as.integer(x[['day']])
  month_names <- c("መስከረም", "ጥቅምት", "ኅዳር", "ታኅሳስ", "ጥር", "የካቲት",
                   "መጋቢት", "ሚያዝያ", "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጉሜ")
  weekday_names <- c("ሐሙስ", "ዓርብ", "ቅዳሜ", "እሁድ", "ሰኞ", "ማክሰኞ", "ረቡዕ")
  eth_weekday <- num_day %% 7

  formatted_date <- format
  formatted_date <- gsub("%Y", eth_year, formatted_date)
  formatted_date <- gsub("%y", sprintf("%02d", eth_year %% 100), formatted_date)
  formatted_date <- gsub("%m", sprintf("%02d", eth_month), formatted_date)
  formatted_date <- gsub("%B", month_names[eth_month], formatted_date)
  formatted_date <- gsub("%b", substr(month_names[eth_month], 1, 3), formatted_date)
  formatted_date <- gsub("%d", sprintf("%02d", eth_day), formatted_date)
  formatted_date <- gsub("%A", weekday_names[eth_weekday + 1], formatted_date)
  formatted_date <- gsub("%a", substr(weekday_names[eth_weekday + 1], 1, 3), formatted_date)
  formatted_date <- gsub("%w", eth_weekday, formatted_date)

  return(formatted_date)
}




#' @export
print.ethDiffDays <- function(x, max = NULL, ...) {
  if(is.null(max)) max <- getOption("max.print", 9999L)
  is_longer <- length(x) > max
  if (is_longer) {
    omit <- length(x) - max
    x <- x[1:max]
  }
  for (i in seq_along(x)) {
    cat("The time difference is", x[i], "days.\n")
  }
  if (is_longer) {
    cat(' [ reached getOption("max.print") -- omitted',
        omit, 'entries ]\n')
  }
}


#' @export
print.ethDate <- function(x, max = NULL, ...) {
  x <- unclass(x)
  if(is.null(max)) max <- getOption("max.print", 9999L)
  is_longer <- length(x) > max
  if (is_longer) {
    omit <- length(x) - max
    x <- x[1:max]
  }
  for (i in seq_along(x)) {
    cat(paste0('[', i, ']'), x[i], "\n")
  }
  if (is_longer) {
    cat(' [ reached getOption("max.print") -- omitted',
        omit, 'entries ]\n')
  }
}

