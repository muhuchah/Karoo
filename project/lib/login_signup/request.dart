import 'dart:convert';

import '../user/user_file.dart';
import 'package:http/http.dart' as http;

class Request{
  static final String _baseUrl = "http://127.0.0.1:8000/";
  static final String _signupUrl = "users/register/";
  static final String _loginUrl = "users/login/";

  static Future<String> signup({
    required String fullName , required String email,
    required String password}) async{
    final response = await http.post(Uri.parse(_baseUrl+_signupUrl),
      body: jsonEncode(<String , String>{
        "password": password,
        "full_name": fullName,
        "email": email,
      }));

    if(response.statusCode == 201){
      return "Please confirm email";
    }
    else if(response.statusCode == 40){
      return jsonDecode(response.body)["message"];
    }
    throw Exception("failed to login");
  }
}