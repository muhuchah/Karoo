import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/create_job/create_job_buttons.dart';

void main(){
  testWidgets("create job button test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ShortButton(text: "test",onTap: (){},),)
    );

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}