import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/edit_info/address.dart';
import 'package:project/profile/user_info.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class ProfileListTile extends StatelessWidget {
  final UserInfo userInfo;
  final String label;
  final String text;
  Function() onTap;
  ProfileListTile({super.key , required this.userInfo ,
    required this.label, required this.text , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15,left: 15,right: 5),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: label, size: 16,
                        textColor: Colors.black, weight:FontWeight.normal),
                    const SizedBox(height: 20,),
                    CustomText(text: text, size: 16,
                        textColor: AppColor.hint, weight:FontWeight.normal)
                ],),
                IconButton(onPressed: (){
                  if(userInfo == UserInfo.address){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                        return EditAddressPage(onTap: onTap,);
                      })
                    );
                  }
                  // _showDialog(context, label);
                }, icon: const Icon(Icons.arrow_forward_ios,)),
            ],),
          ],),
        ),
        const SizedBox(height: 20,),
        Container(height: 1,color: AppColor.divider,
          margin: const EdgeInsets.symmetric(horizontal: 10),)
      ],
    );
  }

  String getBodyParam(){
    if(userInfo == UserInfo.fullName){
      return "full_name";
    }
    else if(userInfo == UserInfo.email){
      return "email";
    }
    else if(userInfo == UserInfo.phoneNumber){
      return "phone_number";
    }
    else{
      return "password";
    }
  }

  void _showDialog(context , label){
    FocusNode focusNode = FocusNode();
    showDialog(context: context, builder: (context){
      TextEditingController controller = TextEditingController();
      return AlertDialog(
        title: Text("Enter $label :"),
        content: TextField(
          controller: controller,
          focusNode: focusNode,
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Cancel")),
          TextButton(onPressed: () async {
            if (controller.text == "") {
              focusNode.requestFocus();
            }
            else {
              try {
                var response = await UserRequest.changeInfo(getBodyParam(),
                    controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response),
                      duration: Duration(seconds: 1),));
              }
              catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()),
                      duration: Duration(seconds: 1),));
              }
              if(userInfo == UserInfo.email){
                _writeBlank();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed("/first");
                Navigator.of(context).pushNamed("/login");
              }
              else{
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/profile");
              }
            }
          }, child: const Text("Save")),
        ],
      );
    });
  }

  Future<void> _writeBlank() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString("");
  }
}
