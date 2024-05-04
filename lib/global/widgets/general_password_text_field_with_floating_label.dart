import 'package:flutter/material.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';


class GeneralPasswordTextFieldWithFloatingLabel extends StatelessWidget {
  const GeneralPasswordTextFieldWithFloatingLabel(
      {super.key,
      required this.controller,
      this.onTap,
      required this.labelText,
      this.onFieldSubmitted,
      required this.obscureText,
      required this.onChanged,
      required this.changeObsecureValue,
        required this.validator,
        required this.color});
  final TextEditingController controller;
  final Function? onTap;
  final bool obscureText;
  final Function? onFieldSubmitted;
  final String labelText;
  final void Function(String) onChanged;
  final void Function() changeObsecureValue;
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
    child: Center(
    child: TextFormField(
        toolbarOptions: const ToolbarOptions(
            copy: true, cut: true, paste: true, selectAll: true),
        style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Color(0xFF000000)),
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        cursorColor: color,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        controller: controller,

        decoration: InputDecoration(
          suffixIconConstraints: BoxConstraints(
            maxWidth: 50,minWidth: 50
          ),
            suffixIcon: IconButton(
              onPressed: changeObsecureValue,
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility,size: 20,color: Color(0xFF9C9C9C),
              ),
            ),



            border: InputBorder.none,

            isDense: true,
            isCollapsed: false,
            contentPadding: EdgeInsets.only(left: MQuery.getheight(context, 16)),
          //label: labelText,
            labelText: labelText,
            hintStyle:  TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
            floatingLabelStyle:  TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w500
              //height: 1.4
            )

        ),
      ),
    ));
  }
}
