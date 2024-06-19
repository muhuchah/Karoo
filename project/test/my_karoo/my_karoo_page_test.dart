import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/my_karoo/my_karoo_page.dart';

void main(){
  testWidgets("My Karoo page testing", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyKarooPage(),));

    expect(find.text("Profile"), findsOneWidget);
    expect(find.text("Orders"), findsOneWidget);
    expect(find.text("Bookmarks"), findsOneWidget);
    expect(find.text("Chats"), findsOneWidget);

    expect(find.byIcon(Icons.wallet_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.add_alert_rounded), findsOneWidget);

    expect(find.text("Help"), findsOneWidget);
    expect(find.text("Support"), findsOneWidget);
    expect(find.text("Karoo FAQ"), findsOneWidget);
    expect(find.text("About Karoo"), findsOneWidget);
    expect(find.text("Contact us"), findsOneWidget);
  });
}