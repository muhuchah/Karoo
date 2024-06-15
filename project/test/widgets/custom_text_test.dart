import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/widgets/custom_text.dart';

void main(){
  testWidgets("custom text test", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CustomText(text: "test text", size: 12,
          textColor: Colors.black, weight: FontWeight.normal),
    ));

    expect(find.text("test text"), findsOneWidget);
  });
}