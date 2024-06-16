import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class About extends StatelessWidget {
  final String text = "Karoo is one of the platform products of Keravieh, "
      "a knowledge-based company, which was founded in 2024 by five graduates"
      " of University of Isfahan.\n\nKaroo allows its users to easily order any home"
      " service they need through the application at any time of the day. These "
      "services range from cleaning and hospitality to home renovation and decoration,"
      " ... .\n\nThis platform uses the information technology expertise of its development"
      " team to directly connect various skilled and trusted service providers with"
      " those who need these services.\n\nThe main goals of this platform include:\n "
      "- Addressing customer concerns regarding home services \n- Bringing innovation"
      " to the home services sector \n- Creating employment opportunities for many"
      " individuals who have technical skills but lack the capital to introduce"
      " themselves and connect with end customers\n\nService providers (specialists) "
      "have certificates of no criminal record and no addiction and have passed "
      "other Karoo qualification filters so that customers can trust them.\n\nAdditionally,"
      " due to the evaluation and rating system by customers, the quality of services"
      " provided is constantly improving, ultimately offering services of higher"
      " quality compared to the average traditional services.\n\nKaroo is a great "
      "opportunity for cleaning, nursing, gardening, repair, and maintenance workers "
      "to earn an income at any time and place they prefer.";

  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "About Karoo", leading: (){
        Navigator.of(context).pop();
      }),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: CustomText(text: text, size: 18
              , textColor: AppColor.text1, weight: FontWeight.w600),
        ),
      ),
    );
  }
}
