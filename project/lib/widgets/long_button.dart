import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import 'custom_text.dart';

class LongButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  const LongButton({super.key , required this.onTap , required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.main,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child:
      SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              textColor: AppColor.background,
              size: 20,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
