import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class MyDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double margin;
  const MyDivider({super.key , this.height = 1 , this.margin = 0,
  this.width = double.infinity , this.color = AppColor.divider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      height: height,
      width: width,
      color: color,
    );
  }
}
