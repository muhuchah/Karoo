import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/utils/app_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "About Karoo", leading: (){
        Navigator.of(context).pop();
      }),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: CustomText(text: AppText.aboutText, size: 18
              , textColor: AppColor.text1, weight: FontWeight.w600),
        ),
      ),
    );
  }
}
