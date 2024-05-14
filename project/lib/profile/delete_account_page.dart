import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/component/user_file.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/custom_text.dart';
import '../widgets/long_button.dart';

class DeletePage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Delete", leading: (){
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
                      const CustomText(text: "Password", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: focus,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter current password";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: "password",
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
                    ],
                  ),
                  LongButton(
                    onTap: () async {
                      if(_formKey.currentState!.validate()){
                        try {
                          User user = User();
                          var response = await UserRequest.deleteAccount(
                              email: user.email!,
                              password: controller.text);
                          _writeBlank();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed("/first");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response),
                              duration: const Duration(seconds: 1),));
                        }
                        catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: const Duration(seconds: 2),)
                          );
                        }
                      }
                      else if(controller.text==""){
                        focus.requestFocus();
                      }
                    },
                    text: "Delete"
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _writeBlank() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString("");
  }
}
