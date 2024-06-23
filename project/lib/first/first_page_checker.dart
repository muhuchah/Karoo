import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/home/home.dart';
import 'package:project/login_signup/phone_city_page.dart';
import 'package:project/request/category_request.dart';

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
                  future: CategoryRequest.mainCategory(),
                  builder: (context, categorySnapshot){
                    if(categorySnapshot.hasData){
                      return _InfoChecker();
                    }
                    else if(categorySnapshot.hasError){
                      return FutureBuilder(
                        future: UserRequest.checkRefresh(refreshToken),
                        builder: (context , snapshot){
                          if(snapshot.hasData){
                            return _InfoChecker();
                          }
                          else if(snapshot.hasError){
                            return FirstPage();
                          }
                          return const CircularProgressIndicator();
                        }
                      );
                    }
                    return CircularProgressIndicator();
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

  Future<String> _read() async {
    String text;
    try {
      User user = User();

      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.txt');
      text = await file.readAsString();
      List<String> values = text.split("\n");
      user.refreshToken = values[0];
      user.accessToken = values[1];
      return "success";
    }
    catch (e) {
      return "";
    }
  }
}

class _InfoChecker extends StatelessWidget{
  User user = User();
  @override
  Widget build(BuildContext context) {
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

}