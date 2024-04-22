import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/component/user_file.dart';
import 'package:project/first/first_page_button.dart';
import 'package:project/home/home.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:path_provider/path_provider.dart';

import '../request/user_requests.dart';

class FirstPageChecker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _read(),
      builder: (context , snapShot){
        if(snapShot.hasData){
          String data = snapShot.data!;
          print(data);
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
          print("error");
          return FirstPage();
        }
        return CircularProgressIndicator();
      }
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

class FirstPage extends StatelessWidget {
  String text = "A network platform that connects people with skills and people who need those skills.";
  String userTokens = "";
  FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const BigText(text: "Karoo", textColor: AppColor.background,),
        backgroundColor: AppColor.main,),
      body: Container(
        height: double.infinity,
        color: AppColor.main,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 280),
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)),
              color: AppColor.background,),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30 , top: 40 , right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Do Do" , size: 24,),
                  SizedBox(height: 30,),
                  BigText(text: text , size: 20,weight: FontWeight.normal,),
                  SizedBox(height: 100,),
                  FirstPageButton(text : "Log in",color: AppColor.button1,
                    onTap: (){
                      Navigator.of(context).pushNamed("/login");
                    },),
                  SizedBox(height: 15,),
                  FirstPageButton(text: "Sign in",color: AppColor.button1,
                    onTap: (){
                      Navigator.of(context).pushNamed("/signup");
                    },
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
