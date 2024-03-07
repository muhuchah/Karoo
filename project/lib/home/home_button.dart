import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../widgets/custom_text.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      print("login");
    },
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child:
      const SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Log in",
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
