import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/faq/faq_text_icon.dart';
import 'package:project/utils/app_text.dart';

void main(){
  testWidgets("faq text icon testing", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: FAQTextIcon(text: "this is test", title: "test"),)
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.text("this is test"), findsNothing);
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(find.text("this is test"), findsOneWidget);
  });
}