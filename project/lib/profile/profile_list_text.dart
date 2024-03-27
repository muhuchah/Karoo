import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class ProfileListText extends StatelessWidget {
  final String text;
  const ProfileListText({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10,left: 10,top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(text , style: TextStyle(fontSize: 20),),
          ),
          SizedBox(height: 10,),
          Container(height: 1,color: AppColor.divider,)
      ],),
    );
  }
}
