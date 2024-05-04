import 'package:flutter/material.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';

class CountryPhoneWidget extends StatelessWidget {
  const CountryPhoneWidget(
      {super.key,
      required this.checkBoxValue,
      required this.onChanged,
      required this.countryLookupsModel});

  final bool checkBoxValue;
  final Function() onChanged;
  final CountryLookupsModel countryLookupsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),

      onTap: onChanged,
      child: Container(
        height: 45,
        width: MQuery.getWidth(context, 360),
        padding: EdgeInsets.only(left: MQuery.getWidth(context, 14),right: MQuery.getWidth(context, 14)),
        child: Row(
          children: [
            SizedBox(
              height: 20,width: 20,
              child: Checkbox(


                  shape: const CircleBorder(),
                  value: checkBoxValue,
                  onChanged: (b) {
                    onChanged();
                  }),
            ),

            SizedBox(
              width: MQuery.getWidth(context, 8),
            ),
            Expanded(
                child: Text(
              '${countryLookupsModel.nameEn} (${countryLookupsModel.dialCode})',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            )),
            if (countryLookupsModel.topLevelDomain.isNotEmpty)
              Image.asset(
                "assets/countries_flags/${countryLookupsModel.topLevelDomain}.png",
                width: 40,
                height: 30,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace){
                  return const SizedBox.shrink();
                },
              ),
          ],
        ),
      ),
    );
  }
}
