import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/login_signup/login_page.dart';

void main(){
  testWidgets("login page test", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage(),));
    
    expect(find.text("Login"), findsOneWidget);
    expect(find.text("Please sign in to continue."), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.enterText(find.byKey(const Key("email")), "test@gmail.com");
    await tester.enterText(find.byKey(const Key("password")), "some password");
  });
}