import 'package:flutter/material.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

class CategoryTextIcon extends StatelessWidget {
  String text;
  void Function() onTap;
  CategoryTextIcon({super.key , required this.text,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10.0 , bottom:10.0 ,
              left: 20 , right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: text, size: 20,
                  textColor: Colors.black, weight: FontWeight.w600),
              IconButton(onPressed: onTap, icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
        MyDivider(margin: 10,),
      ],
    );
  }
}
