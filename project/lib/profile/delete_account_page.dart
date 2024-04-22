import 'package:flutter/material.dart';
import 'package:project/component/user_file.dart';

import '../request/user_requests.dart';

void deleteAccountAlertDialog(context , label , writeBlank){
  FocusNode focusNode = FocusNode();
  showDialog(context: context, builder: (context){
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      title: Text("Enter $label :"),
      content: TextField(
        controller: controller,
        obscureText: true,
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
              User user = User();
              var response = await UserRequest.deleteAccount(
                  email: user.email!,
                  password: controller.text);
              writeBlank;
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("/first");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response),
                    duration: Duration(seconds: 1),)).
                    closed.then((value){
              });
            }
            catch (e) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()),
                    duration: Duration(seconds: 1),));
            }
          }
        }, child: const Text("Delete")),
      ],
    );
  });
}
