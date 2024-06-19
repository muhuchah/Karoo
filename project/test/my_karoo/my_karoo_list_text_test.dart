import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/my_karoo/my_karoo_list_text.dart';
import 'package:project/widgets/divider.dart';

void main(){
  testWidgets("my karoo list text testing", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyKarooListText(text: "test", onTap: (){},),)
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.byType(MyDivider), findsOneWidget);
  });
}