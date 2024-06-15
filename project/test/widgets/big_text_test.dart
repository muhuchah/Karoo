import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/widgets/big_text.dart';

void main(){
  testWidgets("big text test", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: BigText(text: "some big text"),
    ));

    expect(find.text("some big text"), findsOneWidget);
  });
}