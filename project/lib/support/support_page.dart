import 'package:flutter/material.dart';
import 'package:project/request/support_request.dart';
import 'package:project/support/support_chat_page.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

import '../chat/chat_holder.dart';
import '../component/support.dart';
import 'message_holder.dart';

class SupportPage extends StatefulWidget {
  SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Support", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: FutureBuilder(
        future: SupportRequest.getSupportMessages(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SupportChatPage(messages: getChats(snapshot.data!));
          }
          else if(snapshot.hasError){
            return SizedBox(
              height: 200,
              child: Center(child: CustomText(text: snapshot.toString(),
                  size: 20, textColor: Colors.black, weight: FontWeight.normal)
              ),
            );
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }

  List<ChatHolder> getChats(List<SupportMessage> data){
    List<ChatHolder> chats = [];

    for(int i = 0; i<data.length ; i++){
      chats.add(ChatHolder(true, data[i].message, ""));
      if(data[i].reply != "NO REPLY"){
        chats.add(ChatHolder(false, data[i].reply, ""));
      }
    }

    return chats;
  }
}
