import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class CreateJobTextIcon extends StatelessWidget {
  Icon icon;
  String text;
  String onTapString;
  Function() onTap;
  CreateJobTextIcon({super.key , required this.icon , required this.text,
      required this.onTapString , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 10,),
            SizedBox(
              width: 100,
              child: CustomText(text: text, size: 16,
                  textColor: Colors.black, weight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(
          width: 60,
          child: Align(
            alignment: Alignment.center,
            child: CustomText(text: onTapString, size: 16,
                textColor: AppColor.hint, weight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
