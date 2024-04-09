import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../widgets/custom_text.dart';

class FirstPageButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onTap;
  const FirstPageButton({super.key , required this.text, required this.color,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
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
