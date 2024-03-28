import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class TextIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final double size;
  final double fontSize;
  final Color borderColor;
  final Color hintColor;
  final String? Function(String? value)? validatorFunction;
  final FocusNode? focus;
  final TextEditingController? controller;
  const TextIcon({super.key , required this.labelText,
    required this.icon , this.size = 30 ,
    this.fontSize = 16 , this.borderColor = AppColor.text1,
    required this.controller , this.hintColor = AppColor.hint,
    this.validatorFunction , this.focus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focus,
        validator: validatorFunction,
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: fontSize ,
            fontWeight: FontWeight.w600,
            color: hintColor
          ),
          prefixIcon: SizedBox(
            width: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(icon ,size: size,))),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor)),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor)),
          enabledBorder : UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor)),
          focusedBorder : UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor))
      ),),
    );
  }
}