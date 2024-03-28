import 'dart:convert';
import 'user/user_file.dart';
import 'package:http/http.dart' as http;

class Request{
  static final String _baseUrl = "http://192.168.1.4:8000/";
  static final String _signupUrl = "users/register/";
  static final String _loginUrl = "users/login/";
  static final String _personalInfo = "users/settings/personal-info/";

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

  static Future<void> login({required String email,
    required String password}) async{
    String error = "unable to login";
    final response = await http.post(Uri.parse(_baseUrl+_loginUrl),
        headers: <String , String>{"Content-Type": "application/json"},
        body:jsonEncode(<String , String>{
          "password": "12344321",
          "email": "mehranfarhamid82@gmail.com"}
        ));

    if(response.statusCode == 200){
      User user = User();
      user.token = jsonDecode(response.body)["access"];
      return;
    }
    else if(response.statusCode == 401){
      error = jsonDecode(response.body)["non_field_errors"][0];
    }
    throw Exception(error);
  }

  static Future<String> personalInformation() async {
    User user = User();
    final response = await http.get(Uri.parse(_baseUrl+_personalInfo),
        headers: <String , String> {"Content-Type": "application/json",
          "Authorization": "Bearer ${user.token!}",
        });

    if(response.statusCode==200){
      dynamic body = jsonDecode(response.body);
      user.fullName = body["full_name"];
      user.phoneNumber = "09904503067";
      user.email = body["email"];
      user.address = "Isfahan,Isfahan";
      user.password = "12345678";
      return "Success";
    }
    throw Exception("Unable to load information");
  }

  static Future<String> changeInfo(String bodyParam , String bodyValue) async {
    User user = User();
    final response = await http.post(Uri.parse(_baseUrl+_personalInfo),
        headers: <String , String> {"Content-Type": "application/json",
          "Authorization": "Bearer ${user.token!}"},
        body: <String , String>{
          bodyParam : bodyValue
        }
    );

    if(response.statusCode == 200){
      print(response.body);
      return "Success";
    }

    throw Exception("Unable to change info");
  }
}