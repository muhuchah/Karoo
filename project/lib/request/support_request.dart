import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/chat/chat_holder.dart';
import 'package:project/component/support.dart';

import '../component/user_file.dart';

class SupportRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _spam = "support/spam_report/";
  static const String _sendMessage = "support/send_message/";
  static const String _getMessage = "support/chatroom/";
  static const String _cases = "support/cases/";

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

  static Future<void> sendMessage(String message , String email) async {
    User user = User();
    Map values = {
      "recipient_email" : email,
      "content" : message
    };
    var response = await http.post(Uri.parse("$_base$_sendMessage"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.accessToken!}"
      },
      body:jsonEncode(values),
    );

    if (response.statusCode != 201) {
      throw Exception("Unable to send message");
    }
  }

  static Future<List<ChatHolder>> getMessages(String email) async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_getMessage$email/"),
      headers: <String, String>{
        "Authorization": "Bearer ${user.accessToken!}"
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ChatHolder> messages = [];
      for(int i=0;i<body.length;i++){
        messages.add(ChatHolder(body[i]["sender_email"]==user.email,
            body[i]["content"], "12:03"));
      }

      return messages;
    }

    throw Exception("Unable to load messages");
  }

  static Future<List<Case>> getCases() async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_cases"),
      headers: <String, String>{
        "Authorization": "Bearer ${user.accessToken!}"
      }
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Case> cases = [];
      for(int i=0;i<body.length;i++){
        cases.add(Case(id: body[i]["id"], title: body[i]["title"]));
      }
      return cases;
    }

    throw Exception("Unable to load Cases");
  }
}