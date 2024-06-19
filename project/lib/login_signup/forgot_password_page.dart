import 'package:flutter/material.dart';
import 'package:project/first/first_page_button.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/text_icon_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<StatefulWidget> {
  TextEditingController? emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController?.dispose();
    emailFocus.dispose();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BigText(text: "Forgot Password"),
                        const SizedBox(height: 80,),
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
                    ],),
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    margin: EdgeInsets.only(bottom: 40 , left: 20 , right: 20),
                    child: FirstPageButton(onTap:() async {
                      if(_formKey.currentState!.validate()){
                        String? email = emailController?.text??"";
                        try {
                          var response = await UserRequest.
                            forgotPassword(email: email,);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response),
                                duration: Duration(seconds: 2),))
                              .closed.then((value){
                                Navigator.of(context).pop();
                          });
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: Duration(seconds: 2),));
                        }
                      }
                      else if(emailController?.text==null || emailController?.text==""){
                        emailFocus.requestFocus();
                      }
                    }, text: "Send",color: AppColor.main,)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
