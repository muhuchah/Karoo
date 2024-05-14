import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/long_button.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/custom_text.dart';

class EditPasswordPage extends StatelessWidget {
  TextEditingController currentController = TextEditingController();
  FocusNode currentFocus = FocusNode();
  TextEditingController newPassController = TextEditingController();
  FocusNode newPassFocus = FocusNode();
  TextEditingController confirmController = TextEditingController();
  FocusNode confirmFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  Function() onTap;
  EditPasswordPage({super.key , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Change Pass", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 20 , right: 20 , top: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height-150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Current Password", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: currentFocus,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter current password";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: currentController,
                          decoration: const InputDecoration(
                              hintText: "current password",
                              hintStyle: TextStyle(color: AppColor.hint , fontSize: 16),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.key_outlined , size: 30,))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              enabledBorder : UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedBorder : UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1))
                          ),
                        ),
                      ),
                      const SizedBox(height: 60,),
                      const CustomText(text: "New Password", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: newPassFocus,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter new password";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: newPassController,
                          decoration: InputDecoration(
                              hintText: "new password",
                              hintStyle: const TextStyle(color: AppColor.hint , fontSize: 16),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset("asset/icons/password.svg" ,
                                        width: 30 , height: 30,))),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              enabledBorder : const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedBorder : const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1))
                          ),
                        ),
                      ),
                      const SizedBox(height: 60,),
                      const CustomText(text: "Repeat New Password", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: confirmFocus,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please confirm password";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: confirmController,
                          decoration: InputDecoration(
                              hintText: "confirm password",
                              hintStyle: const TextStyle(color: AppColor.hint , fontSize: 16),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset("asset/icons/password.svg" ,
                                        width: 30 , height: 30,))),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              enabledBorder : const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedBorder : const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1))
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                    ],
                  ),
                  LongButton(
                    onTap: () async {
                      if(_formKey.currentState!.validate()){
                        if(newPassController.text != confirmController.text){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("confirm password is not equal to password"),
                                duration: Duration(seconds: 2),)
                          );
                        }
                        else {
                          try {
                            await UserRequest.changeInfo("password",
                                newPassController.text);
                            Navigator.of(context).pop();
                            onTap();
                          }
                          catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString()),
                                  duration: const Duration(seconds: 2),)
                            );
                          }
                        }
                      }
                      else if(currentController.text==""){
                        currentFocus.requestFocus();
                      }
                      else if(newPassController.text==""){
                        newPassFocus.requestFocus();
                      }
                      else if(confirmController.text==""){
                        confirmFocus.requestFocus();
                      }
                    },
                    text: "Save"
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
