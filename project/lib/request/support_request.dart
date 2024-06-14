import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/chat/chat_holder.dart';

import '../component/user_file.dart';
import '../support/message_holder.dart';

class SupportRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _spam = "support/spam_report/";
  static const String _sendMessage = "support/send_message/";
  static const String _getMessage = "support/chatroom/";
  static const String _supportIssues = "support/user_issues/";
  static const String _createIssue = "support/create_issue/";

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

  static Future<List<SupportMessage>> getSupportMessages() async {
    User user = User();
    var response = await http.get(Uri.parse(_base+_supportIssues),
      headers: <String , String>{
        "Authorization": "Bearer ${user.accessToken!}",
      },
    );

    if(response.statusCode == 200){
      List<SupportMessage> messages = [];
      dynamic body = jsonDecode(response.body);
      for(int i=0;i<body.length;i++){
        messages.add(SupportMessage(body[i]["topic"], body[i]["message"],
            body[i]["reply"]));
      }

      return messages;
    }

    throw Exception("unable to load support requests");
  }

  static Future<void> sendSupportMessage(String message) async {
    User user = User();
    var response = await http.post(Uri.parse(_base+_createIssue),
      headers: <String , String>{
        "Authorization": "Bearer ${user.accessToken!}",
      },
      body: <String , String>{
        "topic" : "Support",
        "message" : message
      }
    );

    if(response.statusCode != 201){
      throw Exception("Unable to create issue");
    }
  }
}