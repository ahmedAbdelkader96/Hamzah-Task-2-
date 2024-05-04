import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';

class LookupsShimmerList extends StatelessWidget {
  const LookupsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(left: MQuery.getWidth(context, 14),right: MQuery.getWidth(context, 14)),

        itemBuilder: (context,index){
          return SizedBox(
            width: MQuery.getWidth(context, 328),
            height: 45,
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
          width: MQuery.getWidth(context, 328),
          height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),color: Colors.grey.withOpacity(0.2),
              ),),
            ),
          );

        }, separatorBuilder: (context,index){
     return SizedBox(
        height: 5 ,
      );
    }, itemCount: 20);
  }
}
