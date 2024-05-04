import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/authentication/widgets/country_phone_widget.dart';
import 'package:task2/features/lookups/blocs/countries_lookups/countries_lookups_bloc.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';
import 'package:task2/global/widgets/lookups_shimmer_list.dart';
import 'package:task2/global/widgets/search_text_field.dart';

class ChooseCountryOfPhoneBottomSheet extends StatefulWidget {
  ChooseCountryOfPhoneBottomSheet(
      {super.key, required this.countryLookupsModel});

  CountryLookupsModel countryLookupsModel;

  @override
  State<ChooseCountryOfPhoneBottomSheet> createState() =>
      _ChooseCountryOfPhoneBottomSheetState();
}

class _ChooseCountryOfPhoneBottomSheetState
    extends State<ChooseCountryOfPhoneBottomSheet> {
  TextEditingController searchCountriescontroller = TextEditingController();
  CountryLookupsModel? countryLookupsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryLookupsModel = widget.countryLookupsModel;
  }

  @override
  void dispose() {
    searchCountriescontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(
        children: [
          SizedBox(
            height: MQuery.getheight(context, 11),
          ),
          Container(
            height: MQuery.getheight(context, 6),
            width: MQuery.getWidth(context, 74),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(MQuery.getheight(context, 3)),
                color: const Color(0xFF252525)),
          ),
          SizedBox(
            height: MQuery.getheight(context, 15),
          ),
           const Text(
            "Select Country",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: MQuery.getheight(context, 15),
          ),
          Padding(
            padding: EdgeInsets.only(left: MQuery.getWidth(context, 14),right: MQuery.getWidth(context, 14)),
            child: SearchTextField(
                controller: searchCountriescontroller,
                hintText: 'Search Country',
                onChanged: (v) {
                  setState(() {});
                }),
          ),
          SizedBox(
            height: MQuery.getheight(context, 15),
          ),
          SizedBox(
            height: MQuery.getheight(context, 500),
            child: BlocBuilder<CountriesLookupsBloc, CountriesLookupsState>(
              builder: (context, state) {
                if (state is DoneToFetchCountriesLookupsState) {
                  final List<CountryLookupsModel> countries = state.countries;
                  return ListView.separated(
                      padding: EdgeInsets.only(
                          left: MQuery.getWidth(context, 0),
                          right: MQuery.getWidth(context, 0)),
                      itemBuilder: (context, index) {
                        return (countries[index]
                                .nationalityEn
                                .toLowerCase()
                                .contains(searchCountriescontroller.text
                                    .toLowerCase())||
                            countries[index]
                                .nationalityAr
                                .toLowerCase()
                                .contains(searchCountriescontroller.text
                                .toLowerCase()))
                            ? CountryPhoneWidget(
                                checkBoxValue:
                                    countryLookupsModel == countries[index]
                                        ? true
                                        : false,
                                onChanged: () {
                                  setState(() {
                                    countryLookupsModel = countries[index];
                                  });
                                  Navigator.pop(context, countryLookupsModel);
                                },
                                countryLookupsModel: countries[index],
                              )
                            : const SizedBox.shrink();
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: (countries[index]
                              .nationalityEn
                              .toLowerCase()
                              .contains(searchCountriescontroller.text
                              .toLowerCase())||
                              countries[index]
                                  .nationalityAr
                                  .toLowerCase()
                                  .contains(searchCountriescontroller.text
                                  .toLowerCase()))
                              ? 5
                              : 0,
                        );
                      },
                      itemCount: countries.length);
                }
                return const LookupsShimmerList();
              },
            ),
          ),

          SizedBox(
            height:  MediaQuery.of(context).viewInsets.bottom,
          ),

        ],
      ),
    );
  }
}
