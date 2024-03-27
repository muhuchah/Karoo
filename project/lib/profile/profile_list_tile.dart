import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final double textSize;
  const ProfileListTile({super.key , required this.title,
    required this.icon , this.textSize = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(child:Row(children: [
              Icon(icon,size: 32,),
              SizedBox(width: 30,),
              Text(title,style: TextStyle(fontSize: textSize),),
            ],),),
            IconButton(onPressed: (){

            }, icon: Icon(Icons.arrow_forward_ios))
          ],),
        ),
        SizedBox(height: 10,),
        Container(height: 1,color: AppColor.divider,)
      ],),
    );
  }
}
