import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class MyDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  const MyDivider({super.key , this.height = 1 ,
  this.width = double.infinity , this.color = AppColor.divider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}
