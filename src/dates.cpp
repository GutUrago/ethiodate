#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector weekday_index(IntegerVector x) {
  int n = x.size();
  IntegerVector result(n);

  for (int i = 0; i < n; i++) {
    if (x[i] == NA_INTEGER) {
      result[i] = NA_INTEGER;
    } else if (x[i] > 0) {
      result[i] = (x[i] + 4) % 7;
      if (result[i] == 0) {
        result[i] = 7;
      }
    } else {
      int mod_val = ((x[i] % 7) + 7) % 7;
      result[i] = mod_val + 4;
      if (result[i] > 7) {
        result[i] -= 7;
      }
    }
    if (i % 1000 == 0) {
      checkUserInterrupt();
    }
  }
  return result;
}


// [[Rcpp::export]]
List eth_date_components(DoubleVector x) {
  int base_year = 1962;
  int base_month = 4;
  int base_offset = 23;
  int n = x.size();
  List result(n);

  for (int i = 0; i < n; i++) {

    double x_val = x[i];

    // 1. NA
    if (R_IsNA(x_val)) {
      result[i] = List::create(
        Named("year")  = NA_INTEGER,
        Named("month") = NA_INTEGER,
        Named("day")   = NA_INTEGER,
        Named("td")    = NA_REAL,
        Named("wx")    = NA_INTEGER
      );
      continue;
    }

    // 2. NaN
    if (R_IsNaN(x_val)) {
      result[i] = List::create(
        Named("year")  = NA_INTEGER,
        Named("month") = NA_INTEGER,
        Named("day")   = NA_INTEGER,
        Named("td")    = x_val,
        Named("wx")    = NA_INTEGER
      );
      continue;
    }

    // 3. Inf / -Inf
    if (!R_finite(x_val)) {
      result[i] = List::create(
        Named("year")  = NA_INTEGER,
        Named("month") = NA_INTEGER,
        Named("day")   = NA_INTEGER,
        Named("td")    = x_val,
        Named("wx")    = NA_INTEGER
      );
      continue;
    }

    // 4. Finite values

    int days_int = static_cast<int>(x_val);
    double td = x_val;

    int days = days_int + base_offset;
    int year = base_year;
    int month = base_month;

    int wx = 0;
    if (days_int > 0) {
      wx = (days_int + 4) % 7;
      if (wx == 0) wx = 7;
    } else {
      int mod_val = ((days_int % 7) + 7) % 7;
      wx = mod_val + 4;
      if (wx > 7) wx -= 7;
    }

    while (days > 30 || days <= 0) {
      bool is_leap = (year % 4) == 3;
      int year_days = is_leap ? 366 : 365;

      if (days > year_days) {
        days -= year_days;
        year++;
      } else if (days <= 0) {
        year--;
        bool prev_leap = (year % 4) == 3;
        int prev_year_days = prev_leap ? 366 : 365;
        days += prev_year_days;
      } else {
        days -= 30;
        month++;

        if (month == 13) {
          int pagume_days = is_leap ? 6 : 5;
          if (days > pagume_days) {
            month = 1;
            days -= pagume_days;
            year++;
          }
        }
      }
    }

    result[i] = List::create(
      Named("year")  = year,
      Named("month") = month,
      Named("day")   = days,
      Named("td")    = td,
      Named("wx")    = wx
    );

    if (i % 1000 == 0) {
      Rcpp::checkUserInterrupt();
    }
  }

  return result;
}


// [[Rcpp::export]]
IntegerVector eth_date_validate(IntegerVector year,
                                IntegerVector month,
                                IntegerVector day) {

  int n = year.size();
  int base_offset = 113;
  IntegerVector result(n);

  int invalid = 0;

  for (int i = 0; i < n; i++) {
    if (year[i] == NA_INTEGER || month[i] == NA_INTEGER || day[i] == NA_INTEGER) {
      result[i] = NA_INTEGER;
      invalid++;
      continue;
    }
    if (day[i] < 1 || day[i] > 30) {
      result[i] = NA_INTEGER;
      invalid++;
      continue;
    }
    if (month[i] < 1 || month[i] > 13) {
      result[i] = NA_INTEGER;
      invalid++;
      continue;
    }
    if (month[i] == 13 && day[i] > 5 && year[i] % 4 != 3) {
      result[i] = NA_INTEGER;
      invalid++;
      continue;
    }
    if (month[i] == 13 && day[i] > 6) {
      result[i] = NA_INTEGER;
      invalid++;
      continue;
    }
    int days = 0;
    int cur_year = year[i];
    if (month[i] > 1) {
      days += (month[i] - 1) * 30;
      days += day[i];
    } else {
      days += day[i];
    }
    while (cur_year > 1962) {
      int year_days = ((cur_year - 1) % 4 == 3) ? 366 : 365;
      days += year_days;
      cur_year--;
    }
    while (cur_year < 1962) {
      int year_days = (cur_year % 4 == 3) ? 366 : 365;
      days -= year_days;
      cur_year++;
    }
    result[i] = days - base_offset;
    if (i % 1000 == 0) {
      checkUserInterrupt();
    }
  }
  if ((invalid > 0) & (n > invalid)) {
    std::string message = "Detected " + std::to_string(invalid) + " invalid date" + (invalid == 1 ? "" : "s") + " and coerced to NA.";
    warning(message);
  }

  return result;
}


// [[Rcpp::export]]
LogicalVector eth_leap_year(IntegerVector x) {
  int n = x.size();
  LogicalVector result(n);
  for (int i = 0; i < n; i++) {
    if (x[i] == NA_INTEGER) {
      result[i] = NA_INTEGER;
      continue;
    }
    result[i] = (x[i] + 1) % 4 == 0;
    if (i % 1000 == 0) {
      checkUserInterrupt();
    }
  }
  return result;
}
