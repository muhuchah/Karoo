import 'package:flutter/material.dart';
import 'package:project/request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/text_icon_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<StatefulWidget>{
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController?.dispose();
    passwordController?.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 100),
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
                  const SizedBox(height: 60,),
                  TextIcon(
                    labelText: "EMAIL",
                    icon: Icons.email_outlined,
                    controller: emailController,
                    validatorFunction: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter email";
                      }
                      return null;
                    },
                    focus: emailFocus,
                  ),
                  const SizedBox(height: 30,),
                  TextIcon(
                    labelText: "PASSWORD",
                    icon: Icons.email_outlined,
                    controller: passwordController,
                    validatorFunction: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter password";
                      }
                      return null;
                    },
                    focus: passwordFocus,
                  ),
                  const SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        String? email = emailController?.text??"";
                        String? password = passwordController?.text??"";
                        try {
                          await Request.login(
                              email: email,
                              password: password);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("You login successfully ."),
                                duration: Duration(seconds: 3),))
                              .closed.then((value){
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacementNamed("/myKaroo");
                          });
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: Duration(seconds: 3),));
                        }
                      }
                      else{
                        if(emailController?.text==null || emailController?.text==""){
                          emailFocus.requestFocus();
                        }
                        else if(passwordController?.text==null || passwordController?.text==""){
                          passwordFocus.requestFocus();
                        }
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: const Size(160, 60),
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
                    Navigator.of(context).pushNamed("/forgot_password");
                  },
                    style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
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
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed("/signup");
                      },
                      child: const CustomText(
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
      ),
    );
  }
}
