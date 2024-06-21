import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/about/contact_page.dart';
import 'package:project/utils/app_text.dart';

void main(){
  testWidgets("contact page testing", (tester) async {
    await tester.pumpWidget(
        const MaterialApp(
          home: Contact(),
        )
    );

    expect(find.text(AppText.address), findsOneWidget);
    expect(find.text(AppText.email), findsOneWidget);
    expect(find.text(AppText.phone), findsOneWidget);
    expect(find.text(AppText.telegram), findsOneWidget);
  });
}