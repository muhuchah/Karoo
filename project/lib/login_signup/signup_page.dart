import 'package:flutter/material.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/text_icon_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<StatefulWidget> {
  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    fullNameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    fullNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }

  @override
  Widget build(BuildContext context){
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
              margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BigText(text: "Create Account"),
                  const SizedBox(height: 50,),
                  TextIcon(
                    key: const Key("full_name"),
                    labelText: "FULL NAME",
                    assetPath: "asset/icons/person.svg",
                    controller: fullNameController,
                    validatorFunction: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter full name";
                      }
                      return null;
                    },
                    focus: fullNameFocus,
                  ),
                  const SizedBox(height: 20,),
                  TextIcon(
                    key: const Key("email"),
                    labelText: "EMAIL",
                    assetPath: "asset/icons/email.svg",
                    controller: emailController,
                    validatorFunction: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter email";
                      }
                      return null;
                    },
                    focus: emailFocus,
                  ),
                  const SizedBox(height: 20,),
                  TextIcon(
                    key: const Key("password"),
                    labelText: "PASSWORD",
                    assetPath: "asset/icons/password.svg",
                    controller: passwordController,
                    validatorFunction: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter password";
                      }
                      return null;
                    },
                    focus: passwordFocus,
                    obscure: true,
                  ),
                  const SizedBox(height: 20,),
                  TextIcon(
                    key: const Key("confirm_password"),
                    labelText: "CONFIRM PASSWORD",
                    assetPath: "asset/icons/password.svg",
                    controller: confirmPasswordController,
                    validatorFunction: (value){
                      if(value==null || value.isEmpty){
                        return "Please confirm password";
                      }
                      return null;
                    },
                    focus: confirmPasswordFocus,
                    obscure: true,
                  ),
                  const SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        String? fullName = fullNameController?.text??"";
                        String? email = emailController?.text??"";
                        String? password = passwordController?.text??"";
                        try {
                          await UserRequest.signup(
                              fullName: fullName,
                              email: email,
                              password: password);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("You sign up successfully . please confirm email"),
                                duration: Duration(seconds: 2),))
                          .closed.then((value){
                            Navigator.of(context).pushReplacementNamed("/login");
                          });
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: Duration(seconds: 2),));
                        }
                      }
                      else{
                        if(fullNameController?.text==null || fullNameController?.text==""){
                          fullNameFocus.requestFocus();
                        }
                        else if(emailController?.text==null || emailController?.text==""){
                          emailFocus.requestFocus();
                        }
                        else if(passwordController?.text==null || passwordController?.text==""){
                          passwordFocus.requestFocus();
                        }
                        else if(confirmPasswordController?.text==null || confirmPasswordController?.text==""){
                          confirmPasswordFocus.requestFocus();
                        }
                      }
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
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed("/login");
                      },
                      child: const CustomText(
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
      ),
    );
  }
}
