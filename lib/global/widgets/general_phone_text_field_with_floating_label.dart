


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';

class GeneralPhoneTextFormField extends StatelessWidget {
  const GeneralPhoneTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
    required this.validator,
    required this.countryLookupsModel,
    required this.onTapCountry,
    required this.maxLength,

  }) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final CountryLookupsModel countryLookupsModel;
  final Function() onTapCountry;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      //width: MQuery.getWidth(context, 328),
      margin: EdgeInsets.only(left: MQuery.getWidth(context, 16),right: MQuery.getWidth(context, 16)),
      constraints: BoxConstraints(minHeight: MQuery.getheight(context, 40)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MQuery.getheight(context, 10)) ,
          color: Color(0xFFF4F4F4),
          boxShadow: [
            BoxShadow(
                color: Color(0xFF686868).withOpacity(0.25),
                offset: Offset(0.0, 2),
                blurRadius: 4,
                spreadRadius: 0
            ),
          ]
      ),

      child: TextFormField(
        //initialValue: "",
        maxLength: maxLength,
        //textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,

        keyboardType: Platform.isIOS
            ? TextInputType.numberWithOptions(signed: true, decimal: true)
            : TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        validator: validator,
        controller: controller,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
            decoration: TextDecoration.none),

        decoration: InputDecoration(
          isDense: true,
          counterText: "",
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF999999)),

          prefixIcon: InkWell(
            onTap: onTapCountry,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 56,
              width: 50,
              color: Colors.transparent,
              child: Center(
                child: Image.asset('assets/countries_flags/'+countryLookupsModel.topLevelDomain+'.png',
                width: 35,height: 20,),
              ),
            ),
          ),


          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

        ),
      ),
    );
  }
}

