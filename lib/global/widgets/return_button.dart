
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});



  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      style: IconButton.styleFrom(shape: CircleBorder()),
      constraints: BoxConstraints(
        maxWidth: 50,minWidth: 50,maxHeight: 50,minHeight: 50
      ),
      icon:
      SvgPicture.asset("assets/images/back_arrow.svg",width: 25,color: Colors.black,),
    );
  }
}



class ReturnButtonNotWork extends StatelessWidget {
  const ReturnButtonNotWork({super.key});



  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
      },
      style: IconButton.styleFrom(shape: CircleBorder()),
      constraints: BoxConstraints(
          maxWidth: 50,minWidth: 50,maxHeight: 50,minHeight: 50
      ),
      icon: SvgPicture.asset("assets/images/global/back_arrow.svg",width: 25,color: Colors.transparent,),
    );
  }
}

