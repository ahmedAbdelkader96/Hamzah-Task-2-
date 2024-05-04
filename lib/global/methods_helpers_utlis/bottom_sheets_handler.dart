import 'package:flutter/material.dart';
import 'package:task2/features/authentication/widgets/choose_country_of_phone_bottom_sheet.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';

class BottomSheetsHandler {
  static Future<CountryLookupsModel?> chooseCountry(
      {required BuildContext context,
      required AnimationController animationController,
      required CountryLookupsModel countryLookupsModel}) async {
    CountryLookupsModel? res = await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(12))),
        isScrollControlled: true,
        transitionAnimationController: animationController,
        context: context,
        builder: (context) {
          return ChooseCountryOfPhoneBottomSheet(
              countryLookupsModel: countryLookupsModel);
        });
    if (res != null) {
      return res;
    }
    return null;
  }
}
