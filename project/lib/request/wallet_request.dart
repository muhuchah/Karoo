import 'dart:convert';
import '../component/user_file.dart';
import 'package:http/http.dart' as http;

class WalletRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _wallet = "wallet/";
  static const String _withdraw = "wallet/withdraw/";

  static Future<String> getWalletInfo() async {
    User user = User();
    var response = await http.get(Uri.parse(_base+_wallet),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}",
        }
    );

    if(response.statusCode == 200){
      user.shabaNum = jsonDecode(response.body)["Shaba_number"].toString();
      user.wallet = double.parse(jsonDecode(response.body)["balance"]);
      return "Success";
    }
    else if(response.statusCode == 404){
      user.shabaNum = "";
      user.wallet = 0;
      return "fail";
    }
    else{
      throw Exception("Unable to load shaba number");
    }
  }

  static Future<void> addShabaNum(String shaba) async {
    User user = User();
    var response = await http.post(Uri.parse(_base+_wallet),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}",
        },
        body: <String , String>{
          "Shaba_number" : shaba
        }
    );

    if(response.statusCode == 400){
      throw Exception(jsonDecode(response.body)["error"]);
    }
    else if(response.statusCode != 200 || response.statusCode != 201){
      throw Exception("unable to add shaba number");
    }
  }

  static Future<String> withdraw(double amount) async {
    User user = User();
    var response = await http.post(Uri.parse(_base+_withdraw),
      headers: <String,String>{
        "Authorization": "Bearer ${user.accessToken!}",
        "Content-Type": "application/json"
      },
      body:{
        "amount" : amount
      }
    );

    if(response.statusCode == 200){
      return "success";
    }
    throw Exception("Unable to withdraw");
  }
}