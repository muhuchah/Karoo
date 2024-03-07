import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/text_icon_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            child: const Icon(Icons.arrow_back_ios , color: Colors.black,),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        color: AppColor.background,
        height: double.infinity,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: "Login"),
              SizedBox(height: 10,),
              CustomText(
                text: "Please sign in to continue.",
                size: 20,
                textColor: AppColor.text1,
                weight: FontWeight.normal),
              SizedBox(height: 50,),
              TextIcon(labelText: "Email", icon: Icons.email_outlined,)
            ],
          ),
        ),
      ),
    );
  }
}
