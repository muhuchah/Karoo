import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/widgets/divider.dart';

void main(){
  testWidgets("my divider test", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyDivider(),));

    expect(find.byType(Container), findsOneWidget);
  });
}