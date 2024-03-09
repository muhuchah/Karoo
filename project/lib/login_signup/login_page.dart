import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/text_icon_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<StatefulWidget>{
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

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
            margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BigText(text: "Login"),
                const SizedBox(height: 10,),
                const CustomText(
                    text: "Please sign in to continue.",
                    size: 20,
                    textColor: AppColor.text1,
                    weight: FontWeight.normal),
                const SizedBox(height: 50,),
                TextIcon(
                  labelText: "EMAIL",
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                const SizedBox(height: 30,),
                TextIcon(
                  labelText: "PASSWORD",
                  icon: Icons.email_outlined,
                  controller: passwordController,
                ),
                const SizedBox(height: 40,),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(onPressed: (){

                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.main,
                      fixedSize: Size(160, 60),
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "LOGIN",
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
                TextButton(onPressed: (){

                },
                  style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                  child: const CustomText(
                      text: "Forgot Password?",
                      size: 20,
                      textColor: AppColor.loginText1,
                      weight: FontWeight.normal),
                ),
                const SizedBox(height: 15,),
                Row(children: [
                  const CustomText(
                      text: "Don't have an account?",
                      size: 20,
                      textColor: AppColor.loginText2,
                      weight: FontWeight.normal),
                  const SizedBox(width: 5,),
                  TextButton(onPressed: (){
                  }, child: const CustomText(
                      text: "Sign up",
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
