import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class MyKarooListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final double textSize;
  final void Function() onPressed;
  const MyKarooListTile({super.key ,
    required this.title, required this.icon ,
    required this.onPressed ,this.textSize = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10 , left: 10 , top: 10),
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
            IconButton(onPressed: onPressed,
                icon: Icon(Icons.arrow_forward_ios))
          ],),
        ),
        SizedBox(height: 10,),
        Container(height: 1,color: AppColor.divider,)
      ],),
    );
  }
}
