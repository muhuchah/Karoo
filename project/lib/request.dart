import 'dart:convert';
import 'user/user_file.dart';
import 'package:http/http.dart' as http;

class Request{
  static const String _baseUrl = "http://192.168.1.6:8000/";
  static const String _signupUrl = "users/register/";
  static const String _loginUrl = "users/login/";
  static const String _forgotPasswordUrl = "users/forgotpassword/";
  static const String _personalInfo = "users/settings/personal-info/";
  static const String _logout = "users/logout/";

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
      dynamic body = jsonDecode(response.body);
      user.accessToken = body["access"];
      user.refreshToken = body["refresh"];
      return;
    }
    else if(response.statusCode == 401){
      error = jsonDecode(response.body)["non_field_errors"][0];
    }
    throw Exception(error);
  }

  static Future<String> forgotPassword({required String email}) async{
    String error = "unable to send email";
    final response = await http.post(Uri.parse(_baseUrl+_forgotPasswordUrl),
        headers: <String , String>{"Content-Type": "application/json"},
        body:jsonEncode(<String , String>{
          "email": email}
        ));

    if(response.statusCode == 200){
      return jsonDecode(response.body)["message"];
    }
    throw Exception(error);
  }

  static Future<String> personalInformation() async {
    User user = User();
    final response = await http.get(Uri.parse(_baseUrl+_personalInfo),
        headers: <String , String> {"Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}",
        });

    if(response.statusCode==200){
      _setInfo(jsonDecode(response.body), user);
      return "Success";
    }
    throw Exception("Unable to load information");
  }

  static void _setInfo(dynamic body , User user){
    user.fullName = body["full_name"];
    user.phoneNumber = "09904503067";
    user.email = body["email"];
    user.address = "Isfahan,Isfahan";
    user.password = "12345678";
  }

  static Future<void> changeInfo(String bodyParam , String bodyValue) async {
    User user = User();
    final response = await http.put(Uri.parse(_baseUrl+_personalInfo),
        headers: <String , String> {
            "Authorization": "Bearer ${user.accessToken!}"},
        body: <String , String>{
          bodyParam : bodyValue
        }
    );

    if(response.statusCode == 200){
      _setInfo(jsonDecode(response.body), user);
      return;
    }

    throw Exception("Unable to change info");
  }

  static Future<String> logout() async {
    User user = User();
    final response = await http.post(Uri.parse(_baseUrl+_logout),
      headers: <String , String> {"Content-Type": "application/json",
        "Authorization": "Bearer ${user.accessToken!}",
      },
      body: <String , String> {
        "refresh_token" : user.refreshToken!
      }
    );

    print(jsonDecode(response.body));

    if(response.statusCode == 200){
      return jsonDecode(response.body)["message"];
    }
    throw Exception("Unable to logout");
  }
}