import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/edit_info/password.dart';

void main(){
  testWidgets("edit password test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EditPasswordPage(onTap: (){},),)
    );

    expect(find.text("Current Password"), findsOneWidget);
    expect(find.text("New Password"), findsOneWidget);
    expect(find.text("Repeat New Password"), findsOneWidget);
    expect(find.text("Save"), findsOneWidget);
  });
}