import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

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
      margin: const EdgeInsets.only(right: 10 , left: 10 , top: 10),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(children: [
              Icon(icon,size: 32,),
              const SizedBox(width: 30,),
              Text(title,style: TextStyle(fontSize: textSize),),
            ],),
            IconButton(onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward_ios))
          ],),
        ),
        const SizedBox(height: 10,),
        const MyDivider()
      ],),
    );
  }
}
