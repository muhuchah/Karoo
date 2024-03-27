import 'package:flutter/material.dart';
import 'package:project/login_signup/signup_page.dart';
import 'package:project/my_karoo/my_karoo_page.dart';
import 'package:project/profile/profile_page.dart';
import 'home/home_page.dart';
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
      initialRoute: "/profile",
      routes: {
        "/home" : (context) => HomePage(),
        "/login" : (context) => LoginPage(),
        "/signup" : (context) => SignUpPage(),
        "/profile" : (context) => MyKarooPage(),
        "/edit_profile" : (context) => ProfilePage(),
      },
    );
  }
}
