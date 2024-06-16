import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/chat/chat_holder.dart';
import 'package:project/chat/chat_page.dart';

void main(){
  testWidgets("Chat testing", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ChatPage(name: "Hamid", email: "Hamid@gmail.com", 
          messages: [ChatHolder(true, "This is test", "12:12")] 
      ),
    )); 
    
    expect(find.text("This is test"), findsOneWidget);
    expect(find.text("12:12"), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}