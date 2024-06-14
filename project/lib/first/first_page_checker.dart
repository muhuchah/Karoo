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
              String refreshToken = snapShot.data!;
              if(refreshToken == ""){
                return FirstPage();
              }
              else {
                return FutureBuilder(
                  future: UserRequest.checkRefresh(refreshToken),
                  builder: (context , snapshot){
                    if(snapshot.hasData){
                      User user = User();
                      user.refreshToken = refreshToken;
                      user.accessToken = snapshot.data;
                      successLogin(context);
                    }
                    else if(snapshot.hasError){
                      return FirstPage();
                    }
                    return const CircularProgressIndicator();
                  }
                );
              }
            }
            else if(snapShot.hasError){
              return FirstPage();
            }
            return const CircularProgressIndicator();
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
        await UserRequest.getAddress();
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