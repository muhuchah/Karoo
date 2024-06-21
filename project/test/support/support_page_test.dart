import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/support/message_holder.dart';
import 'package:project/support/support_page.dart';

void main(){
  testWidgets("support page testing", (tester) async {
    List<SupportMessage> messages = [
      SupportMessage("good app", "your app is good", "thanks")
    ];

    Future<List<SupportMessage>> fetchMessages() async{
      return Future.delayed(
          const Duration(seconds: 1),
              (){
            return messages;
          }
      );
    }

    await tester.pumpWidget(MaterialApp(home: SupportPage(future: fetchMessages()),));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text("your app is good"), findsOneWidget);
    expect(find.text("thanks"), findsOneWidget);
  });
}