import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/faq/faq_page.dart';
import 'package:project/utils/app_text.dart';

void main(){
  testWidgets("faq page test", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: KarooFAQ(),));

    AppText.faqValues.forEach((key, value){
      expect(find.text(key), findsOneWidget);
    });
  });
}