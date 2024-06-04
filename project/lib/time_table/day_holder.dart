import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class DayHolderWidget extends StatefulWidget {
  bool value;
  String text;
  DayHolderWidget({super.key , required this.value , required this.text});

  @override
  State<DayHolderWidget> createState() => _DayHolderWidgetState();
}

class _DayHolderWidgetState extends State<DayHolderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.value,
              onChanged: (value){

              }
              
            ),
            CustomText(text: widget.text, size: 20, textColor: widget.value ?
              AppColor.loginText1 : Colors.black, weight: FontWeight.w600)
          ],
        ),

      ],
    );
  }
}
