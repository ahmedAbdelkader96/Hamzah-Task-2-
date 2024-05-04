import 'package:flutter/material.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';

class GeneralTextFieldWithFloatingLabel extends StatelessWidget {
  const GeneralTextFieldWithFloatingLabel(
      {super.key,
      required this.controller,
      this.onTap,
      required this.labelText,
      this.keyboardType,
      required this.onChanged,
      required this.validator,
      required this.color});
  final TextEditingController controller;
  final Function? onTap;
  final String labelText;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      //width: MQuery.getWidth(context, 328),
      margin: EdgeInsets.only(left: MQuery.getWidth(context, 16),right: MQuery.getWidth(context, 16)),
      constraints: BoxConstraints(minHeight: MQuery.getheight(context, 40)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MQuery.getheight(context, 10)),
          color: Color(0xFFF4F4F4),
          boxShadow: [
            BoxShadow(
                color: Color(0xFF686868).withOpacity(0.25),
                offset: Offset(0.0, 2),
                blurRadius: 4,
                spreadRadius: 0),
          ]),
      // padding: EdgeInsets.only(
      //     left: MQuery.getheight(context, 16),
      //     right: MQuery.getheight(context, 16)),
      child: Center(
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          validator: validator,

          // inputFormatters: [
          //   UpperCaseTextFormatter()
          // ],

          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          onChanged: onChanged,
          keyboardType: keyboardType,
          cursorColor: color,

          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          controller: controller,



          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding:  EdgeInsets.only(
                  left: MQuery.getheight(context, 16),
                  right: MQuery.getheight(context, 16)),
              //hintText: labelText,
              labelText: labelText,
              hintStyle: TextStyle(color: color
                  //height: 1.4,
                  ),
              floatingLabelStyle: TextStyle(
                color: color,
                fontSize: 16, fontWeight: FontWeight.w500,
                //height: 1.4
              )),
        ),
      ),
    );
  }
}
