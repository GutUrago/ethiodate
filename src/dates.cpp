#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector as_eth_date_cpp(IntegerVector x) {
  int base_year = 1962;
  int base_month = 4;
  int base_offset = 23;
  int n = x.size();
  CharacterVector result(n);

  for (int i = 0; i < n; i++) {
    if (x[i] == NA_INTEGER) {
      result[i] = NA_STRING;
      continue;
    }

    int days = x[i] + base_offset;
    int year = base_year;
    int month = base_month;

    // Prevent infinite loops or invalid negative years
    if (days < -365 * 1000 || days > 365 * 1000) {
      result[i] = NA_STRING;
      continue;
    }

    while (days > 30 || days <= 0) {
      bool is_leap = (year % 4) == 3;
      int year_days = is_leap ? 366 : 365;

      if (days > year_days) {
        days -= year_days;
        year++;
      } else if (days <= 0) {
        if (year <= -10000) {  // Prevent unrealistic negative years
          result[i] = NA_STRING;
          break;
        }
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

    if (result[i] != NA_STRING) {
      result[i] = std::to_string(year) + "-" +
        (month < 10 ? "0" : "") + std::to_string(month) + "-" +
        (days < 10 ? "0" : "") + std::to_string(days);
    }
  }

  result.attr("class") = "ethDate";
  return result;
}


// [[Rcpp::export]]
IntegerVector to_numeric_cpp(CharacterVector dates, std::string sep = "-") {
  int n = dates.size();
  IntegerVector result(n, NA_INTEGER);

  for (int i = 0; i < n; i++) {
    std::vector<std::string> parts;
    std::string date = Rcpp::as<std::string>(dates[i]);
    size_t pos = 0;
    while ((pos = date.find(sep)) != std::string::npos) {
      parts.push_back(date.substr(0, pos));
      date.erase(0, pos + sep.length());
    }
    parts.push_back(date);

    if (parts.size() != 3) {
      continue;
    }

    int year, month, days;
    try {
      year = std::stoi(parts[0]);
      month = std::stoi(parts[1]);
      days = std::stoi(parts[2]);
    } catch (...) {
      continue;
    }

    bool is_leap = (year % 4 == 3);
    int max_days = (month == 13) ? (is_leap ? 6 : 5) : 30;

    if (month < 1 || month > 13 || days < 1 || days > max_days) {
      continue;
    }

    if (month == 1) {
      month -= 1;
    }

    while (month > 1) {
      days += 30;
      month--;
    }

    while (year > 1962) {
      int year_days = ((year - 1) % 4 == 3) ? 366 : 365;
      days += year_days;
      year--;
    }

    while (year < 1962) {
      int year_days = (year % 4 == 3) ? 366 : 365;
      days -= year_days;
      year++;
    }

    result[i] = days - 113;
  }

  return result;
}


// [[Rcpp::export]]
CharacterVector parse_eth_date_cpp(CharacterVector dates, std::string sep = "-", std::string orders = "ymd") {
  int n = dates.size();
  CharacterVector result(n, NA_STRING);

  if (orders.size() != 3 || orders.find("y") == std::string::npos ||
      orders.find("m") == std::string::npos || orders.find("d") == std::string::npos) {
    stop("Invalid order format. Use 'y' for year, 'm' for month, and 'd' for day.");
  }

  size_t y_index = orders.find("y");
  size_t m_index = orders.find("m");
  size_t d_index = orders.find("d");

  for (int i = 0; i < n; i++) {
    if (dates[i] == NA_STRING) continue;

    std::vector<std::string> parts;
    std::string date = Rcpp::as<std::string>(dates[i]);
    size_t pos = 0;

    while ((pos = date.find(sep)) != std::string::npos) {
      parts.push_back(date.substr(0, pos));
      date.erase(0, pos + sep.length());
    }
    parts.push_back(date);

    if (parts.size() != 3) continue;

    int year, month, day;

    try {
      year = std::stoi(parts[y_index]);
      month = std::stoi(parts[m_index]);
      day = std::stoi(parts[d_index]);
    } catch (...) {
      continue;  // Skip invalid numeric conversion
    }

    // Leap year check
    bool is_leap = (year % 4 == 3);

    // Validate month and day
    if (month < 1 || month > 13) continue;
    if (day < 1 || day > 30) continue;
    if (month == 13 && day > (is_leap ? 6 : 5)) continue;  // Ensure Pagumē constraints

    // Valid date, format correctly
    result[i] = std::to_string(year) + "-" +
      (month < 10 ? "0" : "") + std::to_string(month) + "-" +
      (day < 10 ? "0" : "") + std::to_string(day);
  }

  result.attr("class") = "ethDate";
  return result;
}

