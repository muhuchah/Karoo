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

    if(response.statusCode == 201){
      return "Please confirm email";
    }
    else if(response.statusCode == 400){
      error = jsonDecode(response.body)["email"][0];
    }
    throw Exception(error);
  }

  static Future<String> login({required String email,
    required String password}) async{
    String error = "unable to login";
    final response = await http.post(Uri.parse(_baseUrl+_loginUrl),
        headers: <String , String>{"Content-Type": "application/json"},
        body:jsonEncode(<String , String>{
          "password": password,
          "email": email}
        ));

    if(response.statusCode == 200){
      return jsonDecode(response.body)["access"];
    }
    else if(response.statusCode == 401){
      error = jsonDecode(response.body)["non_field_errors"][0];
    }
    throw Exception(error);
  }
}