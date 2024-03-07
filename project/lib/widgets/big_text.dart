import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double size;
  final FontWeight weight;

  const BigText({super.key , required this.text,
    this.size = 24 , this.textColor = AppColor.text1 ,
    this.weight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(text ,
      style: TextStyle(
        color: textColor ,
        fontSize: size,
        fontWeight: weight
      ),
    );
  }
}
