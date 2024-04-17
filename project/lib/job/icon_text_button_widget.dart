import 'package:flutter/material.dart';
import 'package:project/widgets/custom_text.dart';

class IconTextButton extends StatelessWidget {
  Icon icon;
  String text;
  TextButton textButton;
  IconTextButton({super.key , required this.icon,
    required this.text , required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 5,),
            SizedBox(
              width: 100,
              child: CustomText(text: text, size: 16,
                  textColor: Colors.black, weight: FontWeight.w500),
            ),
          ],
        ),
        textButton,
      ],
    );
  }
}
