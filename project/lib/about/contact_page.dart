import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/utils/app_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Contact Us", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: const Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(text: "Phone", size: 16,
                    textColor: Colors.black, weight: FontWeight.w600),
                Spacer(),
                CustomText(text: AppText.phone, size: 16,
                    textColor: Colors.black, weight: FontWeight.w400),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                CustomText(text: "Email", size: 16,
                    textColor: Colors.black, weight: FontWeight.w600),
                Spacer(),
                CustomText(text: AppText.email, size: 16,
                    textColor: Colors.black, weight: FontWeight.w400),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                CustomText(text: "Telegram", size: 16,
                    textColor: Colors.black, weight: FontWeight.w600),
                Spacer(),
                CustomText(text: AppText.telegram, size: 16,
                    textColor: Colors.black, weight: FontWeight.w400),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                CustomText(text: "Address", size: 16,
                    textColor: Colors.black, weight: FontWeight.w600),
                Spacer(),
                CustomText(text: AppText.address, size: 16,
                    textColor: Colors.black, weight: FontWeight.w400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
