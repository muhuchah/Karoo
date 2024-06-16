import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/chat/chat_holder.dart';
import 'package:project/chat/chat_page_holder.dart';

void main(){
  testWidgets("testing chat page holder", (tester) async {
    List<ChatHolder> messages = [
      ChatHolder(true, "hi name 1", "12:12"),
      ChatHolder(true, "hi name 2", "12:13")
    ];

    Future<List<ChatHolder>> fetchMessages() async{
      return Future.delayed(
        const Duration(seconds: 1),
        (){
          return messages;
        }
      );
    }

    await tester.pumpWidget(MaterialApp(
      home: ChatPageHolder(email: "email", name: "some name",
        future: fetchMessages(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text("hi name 1"), findsOneWidget);
    expect(find.text("hi name 2"), findsOneWidget);
  });
}