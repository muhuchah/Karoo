import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../widgets/custom_text.dart';

class HomeButton extends StatelessWidget {
  final String text;
  const HomeButton({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Navigator.of(context).pushNamed("/login");
    },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button1,
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
