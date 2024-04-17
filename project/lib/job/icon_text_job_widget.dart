import 'package:flutter/material.dart';
import 'package:project/widgets/custom_text.dart';

class IconText extends StatelessWidget {
  Icon icon;
  String text;
  String info;
  IconText({super.key , required this.icon,
    required this.text , required this.info});

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
        CustomText(text: info, size: 16,
            textColor: Colors.black, weight: FontWeight.normal),
      ],
    );
  }
}
