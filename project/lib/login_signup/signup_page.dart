import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/text_icon_widget.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.background,
        scrolledUnderElevation: 0,
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
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.background,
          height: screenHeight - kToolbarHeight,

          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BigText(text: "Create Account"),
                const SizedBox(height: 50,),
                TextIcon(
                  labelText: "FULL NAME",
                  icon: Icons.person_outline,
                  controller: fullNameController,
                ),
                const SizedBox(height: 20,),
                TextIcon(
                  labelText: "EMAIL",
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                const SizedBox(height: 20,),
                TextIcon(
                  labelText: "PASSWORD",
                  icon: Icons.email_outlined,
                  controller: passwordController,
                ),
                const SizedBox(height: 20,),
                TextIcon(
                  labelText: "CONFIRM PASSWORD",
                  icon: Icons.email_outlined,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 40,),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(onPressed: (){

                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.main,
                      fixedSize: Size(180, 60),
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "SIGN UP",
                          size: 20,
                          textColor: AppColor.background,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(width: 20,),
                        Icon(Icons.arrow_forward , size: 30 ,color: AppColor.background,)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60,),
                Row(children: [
                  const CustomText(
                      text: "Already have an account?",
                      size: 20,
                      textColor: AppColor.loginText2,
                      weight: FontWeight.normal),
                  const SizedBox(width: 5,),
                  TextButton(onPressed: (){
                  }, child: const CustomText(
                      text: "Sign in",
                      size: 20,
                      textColor: AppColor.loginText1,
                      weight: FontWeight.normal),)
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
