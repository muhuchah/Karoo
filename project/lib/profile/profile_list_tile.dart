import 'package:flutter/material.dart';
import 'package:project/profile/user_info.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class ProfileListTile extends StatelessWidget {
  final UserInfo userInfo;
  final String label;
  final String text;
  final bool isPassword;
  const ProfileListTile({super.key , required this.userInfo ,
    required this.label, required this.text , this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15,left: 15,right: 5),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: label, size: 16,
                        textColor: Colors.black, weight:FontWeight.normal),
                    SizedBox(height: 20,),
                    CustomText(text: getText(), size: 16,
                        textColor: AppColor.hint, weight:FontWeight.normal)
                ],),
                IconButton(onPressed: (){
                  _showDialog(context, label);
                }, icon: Icon(Icons.arrow_forward_ios,)),
            ],),
          ],),
        ),
        SizedBox(height: 20,),
        Container(height: 1,color: AppColor.divider,
          margin: EdgeInsets.symmetric(horizontal: 10),)
      ],
    );
  }

  String getText(){
    if(isPassword){
      String temp = "";
      for(int i=0;i<text.length;i++){
        temp+="*";
      }
      return temp;
    }
    return text;
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
    else if(userInfo == UserInfo.address){
      return "address";
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
                      duration: Duration(seconds: 3),));
              }
              catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()),
                      duration: Duration(seconds: 3),));
              }
              if(userInfo == UserInfo.email){
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
}
