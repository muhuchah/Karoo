import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../component/user_file.dart';
import '../request/user_requests.dart';
import 'first_page.dart';

class FirstPageChecker extends StatelessWidget{
  const FirstPageChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _read(),
          builder: (context , snapShot){
            if(snapShot.hasData){
              String data = snapShot.data!;
              if(data == ""){
                return FirstPage();
              }
              else {
                List<String> tokens = data.split("\n");
                User user = User();
                user.refreshToken = tokens[0];
                user.accessToken = tokens[1];
                successLogin(context);
              }
            }
            else if(snapShot.hasError){
              return FirstPage();
            }
            return CircularProgressIndicator();
          }
        ),
      ),
    );
  }

  void successLogin(context) async{
    User user = User();
    try{
      await UserRequest.personalInformation();
      if(user.phoneNumber == null){
        Navigator.of(context).pushReplacementNamed("/phone_city");
      }
      else{
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()) , duration: Duration(seconds: 2),));
    }
  }

  Future<String> _read() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      text = await file.readAsString();
      return text;
    }
    catch (e) {
      return "";
    }
  }
}