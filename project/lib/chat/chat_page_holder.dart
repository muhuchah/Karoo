import 'package:flutter/material.dart';
import 'package:project/chat/chat_page.dart';

import '../request/support_request.dart';
import '../widgets/custom_text.dart';
import 'chat_holder.dart';

class ChatPageHolder extends StatelessWidget {
  String name;
  String email;
  Future<List<ChatHolder>> future;

  ChatPageHolder({super.key , required this.email , required this.name ,
    required this.future
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context , snapshot){
          if(snapshot.hasData){
            return ChatPage(name: name, email: email , messages: snapshot.data!);
          }
          else if(snapshot.hasError){
            return SizedBox(
              height: 200,
              child: Center(child: CustomText(text: snapshot.toString(),
                  size: 20, textColor: Colors.black, weight: FontWeight.normal)
              ),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
