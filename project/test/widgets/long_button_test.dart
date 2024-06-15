import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/widgets/long_button.dart';

void main(){
  testWidgets("long button test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LongButton(onTap: (){}, text: "test button"),
    ));

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}