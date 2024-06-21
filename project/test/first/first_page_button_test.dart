import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/first/first_page_button.dart';

void main(){
  testWidgets("first page button testing", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FirstPageButton(text: "test", color: Colors.black, onTap: (){}),
      )
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}