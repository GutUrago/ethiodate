#include <Rcpp.h>
#include <regex>
using namespace Rcpp;

// Define month and weekday names in different languages
const std::vector<std::string> months_amh_full = {"መስከረም", "ጥቅምት", "ህዳር", "ታህሳስ", "ጥር", "የካቲት", "መጋቢት", "ሚያዝያ", "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጉሜ"};
const std::vector<std::string> months_amh_short = {"መስ", "ጥቅ", "ህዳ", "ታህ", "ጥር", "የካ", "መጋ", "ሚያ", "ግን", "ሰኔ", "ሐም", "ነሐ", "ጳጉ"};
const std::vector<std::string> months_lat_full = {"Meskerem", "Tikimt", "Hidar", "Tahsas", "Tir", "Yekatit", "Megabit", "Miyazya", "Ginbot", "Sene", "Hamle", "Nehase", "Pagume"};
const std::vector<std::string> months_lat_short = {"Mesk", "Tik", "Hid", "Tah", "Tir", "Yek", "Meg", "Miy", "Gin", "Sen", "Ham", "Neh", "Pag"};
const std::vector<std::string> months_en_full = {"September", "October", "November", "December", "January", "February", "March", "April", "May", "June", "July", "August", "Pagume"};
const std::vector<std::string> months_en_short = {"Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Pag"};
const std::vector<std::string> weekdays_amh_full = {"ሰኞ", "ማክሰኞ", "ረቡዕ", "ሐሙስ", "ዓርብ", "ቅዳሜ", "እሁድ"};
const std::vector<std::string> weekdays_amh_short = {"ሰኞ", "ማክ", "ረቡ", "ሐሙ", "ዓር", "ቅዳ", "እሁ"};
const std::vector<std::string> weekdays_lat_full = {"Segno", "Maksegno", "Rebu", "Hamus", "Arb", "Kidame", "Ehud"};
const std::vector<std::string> weekdays_lat_short = {"Seg", "Mak", "Reb", "Ham", "Arb", "Kid", "Ehu"};
const std::vector<std::string> weekdays_en_full = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
const std::vector<std::string> weekdays_en_short = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};

// [[Rcpp::export]]
CharacterVector eth_format_date(List x, std::string format, std::string lang) {
  int n = x.size();
  CharacterVector formatted(n);

  for (int i = 0; i < n; i++) {
    List elem = x[i];
    int year = elem["year"];
    int month = elem["month"];
    int day = elem["day"];
    int td = elem["td"];
    int wx = elem["wx"];

    if (year == NA_INTEGER) {
      formatted[i] = NA_STRING;
      continue;
    }

    std::string f = format;
    f = std::regex_replace(f, std::regex("%Y"), std::to_string(year));
    f = std::regex_replace(f, std::regex("%y"), std::to_string(year).substr(2, 2));
    f = std::regex_replace(f, std::regex("%m"), (month < 10 ? "0" : "") + std::to_string(month));
    f = std::regex_replace(f, std::regex("%d"), (day < 10 ? "0" : "") + std::to_string(day));
    f = std::regex_replace(f, std::regex("%B"), lang == "amh" ? months_amh_full[month - 1] : lang == "lat" ? months_lat_full[month - 1] : months_en_full[month - 1]);
    f = std::regex_replace(f, std::regex("%b"), lang == "amh" ? months_amh_short[month - 1] : lang == "lat" ? months_lat_short[month - 1] : months_en_short[month - 1]);
    f = std::regex_replace(f, std::regex("%A"), lang == "amh" ? weekdays_amh_full[wx - 1] : lang == "lat" ? weekdays_lat_full[wx - 1] : weekdays_en_full[wx - 1]);
    f = std::regex_replace(f, std::regex("%a"), lang == "amh" ? weekdays_amh_short[wx -1 ] : lang == "lat" ? weekdays_lat_short[wx - 1] : weekdays_en_short[wx - 1]);

    formatted[i] = f;
  }
  return formatted;
}
