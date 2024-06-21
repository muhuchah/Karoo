import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/first/first_page.dart';
import 'package:project/first/first_page_button.dart';

void main(){
  testWidgets("first page testing", (tester) async {
    await tester.pumpWidget(MaterialApp(home: FirstPage(),));

    expect(find.text("Do Do"), findsOneWidget);
    expect(find.text("Karoo"), findsOneWidget);
    expect(find.text("A network platform that connects people with skills and people who need those skills."), findsOneWidget);
    expect(find.text("Log in"), findsOneWidget);
    expect(find.text("Sign in"), findsOneWidget);
    expect(find.byType(FirstPageButton), findsNWidgets(2));
  });
}