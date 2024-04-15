import 'package:flutter/material.dart';
import 'package:project/home/home.dart';
import 'package:project/login_signup/drop_down_button.dart';
import 'package:project/login_signup/forgot_password_page.dart';
import 'package:project/login_signup/phone_city_page.dart';
import 'package:project/login_signup/signup_page.dart';
import 'package:project/my_karoo/my_karoo_page.dart';
import 'package:project/profile/profile_page.dart';
import 'first/first_page.dart';
import 'login_signup/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter"
      ),
      title: 'Flutter Demo',
      initialRoute: "/first",
      routes: {
        "/first" : (context) => FirstPage(),
        "/login" : (context) => LoginPage(),
        "/signup" : (context) => SignUpPage(),
        "/forgot_password" : (context) => ForgotPassword(),
        "/phone_city" : (context) => PhoneCityPage(),
        "/home" : (context) => Home(),
        "/myKaroo" : (context) => MyKarooPage(),
        "/profile" : (context) => ProfilePage(),
      },
    );
  }
}
