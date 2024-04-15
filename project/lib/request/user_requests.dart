import 'dart:convert';
import '../component/user_file.dart';
import 'package:http/http.dart' as http;

class UserRequest{
  static const String _baseUrl = "http://192.168.137.1:8000/";
  static const String _signupUrl = "users/register/";
  static const String _loginUrl = "users/login/";
  static const String _forgotPasswordUrl = "users/forgotpassword/";
  static const String _personalInfo = "users/settings/personal-info/";
  static const String _logout = "users/logout/";
  static const String _deleteAccount = "users/delete-account/";
  static const String _provinces = "users/provinces/";
  static const String _cities = "users/cities/";
  static const String _address = "users/settings/address-list/";

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
      _setInfo(jsonDecode(response.body));
      return "Success";
    }
    throw Exception("Unable to load information");
  }

  static void _setInfo(dynamic body){
    User user = User();
    user.fullName = body["full_name"];
    user.email = body["email"];
    user.phoneNumber = body["phone_number"];
    user.address = body["address"];
  }

  static Future<String> changeInfo(String bodyParam , String bodyValue) async {
    User user = User();
    final response = await http.put(Uri.parse(_baseUrl+_personalInfo),
        headers: <String , String> {
            "Authorization": "Bearer ${user.accessToken!}"},
        body: <String , String>{
          bodyParam : bodyValue
        }
    );

    if(response.statusCode == 200){
      dynamic body = jsonDecode(response.body);
      _setInfo(body);
      if(body["message"]==null){
        return "success";
      }
      return body["message"];
    }

    throw Exception("Unable to change info");
  }

  static Future<String> logout() async {
    User user = User();
    String errorMessage = "Unable to logout";
    final response = await http.post(Uri.parse(_baseUrl+_logout),
      headers: <String , String> {
        "Authorization": "Bearer ${user.accessToken!}"
      },
      body: <String , String> {
        "refresh": user.refreshToken!
      }
    );

    dynamic body = jsonDecode(response.body);

    if(response.statusCode == 200){
      user.setNullPart();
      return body["message"];
    }
    else{
      if(body["error"] != null){
        errorMessage = body["error"];
      }
      else if(body["message"]!= null){
        errorMessage = body["message"];
      }
    }
    throw Exception(errorMessage);
  }

  static Future<String> deleteAccount({required String email,
    required String password}) async{
    User user = User();
    final response = await http.post(Uri.parse(_baseUrl+_deleteAccount),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}",
        },
        body:{
          "password": password,
          "email": email}
        );

    if(response.statusCode == 200){
      user.setNullPart();
      dynamic body = jsonDecode(response.body);
      return body["message"];
    }
    throw Exception("unable to delete account");
  }

  static Future<List<String>> getProvinces() async{
    User user = User();
    final response = await http.get(Uri.parse(_baseUrl+_provinces),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}",
        },
    );

    if(response.statusCode == 200){
      List<String> province = ["-----"];
      List<dynamic> values = jsonDecode(response.body);

      for(int i = 0;i<values.length ; i++){
        province.add(values[i]["name"]);
      }
      return province;
    }
    throw Exception("unable to load provinces");
  }

  static Future<List<String>> getCities(String province) async{
    User user = User();
    final response = await http.post(Uri.parse(_baseUrl+_cities),
      headers: <String , String>{
        "Authorization": "Bearer ${user.accessToken!}",
      },
      body: <String , String>{
        "province" : province
      }
    );

    if(response.statusCode == 200){
      List<String> cities = ["-----"];
      List<dynamic> values = jsonDecode(response.body);

      for(int i = 0;i<values.length ; i++){
        cities.add(values[i]["name"]);
      }
      return cities;
    }
    throw Exception("unable to load cities");
  }

  static Future<void> setAddress(String province , String city) async {
    User user = User();
    final response = await http.post(Uri.parse(_baseUrl+_address),
        headers: <String , String> {
          "Authorization": "Bearer ${user.accessToken!}"},
        body: <String , String>{
          "province":province,
          "city":city
        }
    );

    print(response.statusCode);

    if(response.statusCode == 201){
      dynamic body = jsonDecode(response.body);
      user.address = body["province_name"]+","+body["city_name"];
    }
    else if(response.statusCode == 404 || response.statusCode == 400){
      throw Exception(jsonDecode(response.body)["message"]);
    }
    else {
      throw Exception("Unable to add address");
    }
  }
}