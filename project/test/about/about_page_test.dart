import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/about/about_page.dart';
import 'package:project/utils/app_text.dart';

void main(){
  testWidgets("testing about page", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: About(),
      )
    );

    var text = find.text(AppText.aboutText);
    expect(text, findsOneWidget);
  });
}