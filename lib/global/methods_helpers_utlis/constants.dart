import 'package:task2/features/lookups/models/country_lookups_model.dart';

class Constants {
  static String get usersTable => 'users';
  static String get userIdColumn => 'user_id';

  static String get countriesLookupTable => 'countries_lookups';
  static CountryLookupsModel get defaultCountryModel => CountryLookupsModel(countryId: 158,iso2: "SA", dialCode: "+966", nameEn: "Saudi Arabia", nameAr: "السعودية", nationalityAr: "سعودي", nationalityEn: "Saudi Arabian", topLevelDomain: "sa");
  static RegExp get emailRegExp => RegExp(
  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

}
