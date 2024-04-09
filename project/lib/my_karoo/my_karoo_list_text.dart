import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

class MyKarooListText extends StatelessWidget {
  final String text;
  const MyKarooListText({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10,left: 10,top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextButton(onPressed: (){

            },child: Text(text , style: const TextStyle(fontSize: 20),),),
          ),
          const SizedBox(height: 10,),
          const MyDivider()
      ],),
    );
  }
}
