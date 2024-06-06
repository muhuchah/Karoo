import 'dart:convert';

import 'package:http/http.dart' as http;

import '../component/user_file.dart';

class SupportRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _spam = "support/spam_report/";

  static Future<void> spam(String message , int jobId) async {
    User user = User();
    Map values = {
      "message" : message,
      "job" : jobId
    };
    var response = await http.post(Uri.parse("$_base$_spam"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.accessToken!}"
      },
      body:jsonEncode(values),
    );

    if (response.statusCode != 201) {
      throw Exception("Unable to send report");
    }
  }
}