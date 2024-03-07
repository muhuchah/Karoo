import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class TextIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final double size;
  final double fontSize;
  const TextIcon({super.key , required this.labelText,
    required this.icon , this.size = 40 , this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextField(
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: fontSize ,
            fontWeight: FontWeight.w600,
            color: AppColor.hint
          ),
          prefixIcon: SizedBox(
            width: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(icon ,size: size,))),
          border : const UnderlineInputBorder()
      ),),
    );
  }
}
