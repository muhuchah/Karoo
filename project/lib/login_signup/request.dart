import 'dart:convert';

import '../user/user_file.dart';
import 'package:http/http.dart' as http;

class Request{
  static final String _baseUrl = "http://192.168.137.1:8000/";
  static final String _signupUrl = "users/register/";
  static final String _loginUrl = "users/login/";

  static Future<String> signup({
    required String fullName , required String email,
    required String password}) async{
    String error = "unable to signup";
    final response = await http.post(Uri.parse(_baseUrl+_signupUrl),
      headers: <String , String>{"Content-Type": "application/json"},
      body:jsonEncode(<String , String>{
        "password": password,
        "full_name": fullName,
        "email": email}
      ));
    //
    // print(response.statusCode);
    //
    if(response.statusCode == 201){
      return "Please confirm email";
    }
    else if(response.statusCode == 40){
      error = jsonDecode(response.body)["message"];
    }
    throw Exception(error);
  }
}