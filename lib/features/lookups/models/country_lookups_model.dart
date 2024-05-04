class CountryLookupsModel {
  int countryId;
  String iso2;
  String dialCode;
  String nameEn;
  String nameAr;
  String nationalityAr;
  String nationalityEn;
  String topLevelDomain;

  CountryLookupsModel({
    required this.countryId,
    required this.iso2,
    required this.dialCode,
    required this.nameEn,
    required this.nameAr,
    required this.nationalityAr,
    required this.nationalityEn,
    required this.topLevelDomain,
  });

  factory CountryLookupsModel.fromJson(Map<String, dynamic> json) =>
      CountryLookupsModel(
        countryId: json['country_id'],
        iso2: json['iso2'],
        dialCode: json['dial_code'],
        nameEn: json['name_en'],
        nameAr: json['name_ar'],
        nationalityAr: json['nationality_ar'],
        nationalityEn: json['nationality_en'],
        topLevelDomain: json['top_level_domain'],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "iso2": iso2,
        "dial_code": dialCode,
        "name_en": nameEn,
        "name_ar": nameAr,
        "nationality_ar": nationalityAr,
        "nationality_en": nationalityEn,
        "top_level_domain": topLevelDomain,
      };
}
