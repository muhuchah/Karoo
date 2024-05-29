import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

class MyKarooListText extends StatelessWidget {
  final String text;
  final Color color;
  Function() onTap;
  MyKarooListText({super.key , required this.text , this.color = Colors.black,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10,left: 10,top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextButton(onPressed: (){
              onTap();
            },child: Text(text , style: TextStyle(fontSize: 20 , color: color),),
            ),
          ),
          const SizedBox(height: 10,),
          const MyDivider()
      ],),
    );
  }
}
