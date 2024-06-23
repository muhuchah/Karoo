import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/home/home.dart';
import 'package:project/login_signup/phone_city_page.dart';

import '../component/user_file.dart';
import '../request/user_requests.dart';
import '../widgets/custom_text.dart';
import 'first_page.dart';

class FirstPageChecker extends StatelessWidget{
  FirstPageChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _read(),
          builder: (context , readSnapShot){
            if(readSnapShot.hasData){
              String refreshToken = readSnapShot.data!;
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
                      return FutureBuilder(
                        future: UserRequest.personalInformation(),
                        builder: (context , personalSnapshot) {
                          if (personalSnapshot.hasData) {
                            if(user.phoneNumber == null){
                              return const PhoneCityPage();
                            }
                            else{
                              return FutureBuilder(
                                future: UserRequest.getAddress(),
                                builder: (context , addressSnapshot) {
                                  if (addressSnapshot.hasData) {
                                    return Home();
                                  }
                                  else if(addressSnapshot.hasError){
                                    return SizedBox(
                                      height: 200,
                                      child: Center(child: CustomText(text: addressSnapshot.toString(),
                                          size: 20, textColor: Colors.black, weight: FontWeight.normal)
                                      ),
                                    );
                                  }
                                  return const CircularProgressIndicator();
                                }
                              );
                            }
                          }
                          else if(personalSnapshot.hasError){
                            return SizedBox(
                              height: 200,
                              child: Center(child: CustomText(text: personalSnapshot.toString(),
                                  size: 20, textColor: Colors.black, weight: FontWeight.normal)
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }
                      );
                    }
                    else if(snapshot.hasError){
                      return FirstPage();
                    }
                    return const CircularProgressIndicator();
                  }
                );
              }
            }
            else if(readSnapShot.hasError){
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
          SnackBar(content: Text(e.toString()) , duration: const Duration(seconds: 2),));
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