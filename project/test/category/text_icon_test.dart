import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/category/category_text_icon.dart';

void main(){
  testWidgets("text icon test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MainCategoryTextIcon(text: "test", onTap: (){}),
    ));

    expect(find.text("test"), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
  });
}