import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/user_file.dart';
import 'package:project/profile/profile_page.dart';

void main(){
  testWidgets("profile page testing", (tester) async {
    User user = User();
    user.fullName = "Hamid";
    user.email = "test@gmail.com";
    user.phoneNumber = "0123456789";
    user.province = "Isfahan";
    user.city = "Shahreza";

    await tester.pumpWidget(const MaterialApp(home: ProfilePage(),));

    expect(find.text(user.fullName!), findsOneWidget);
    expect(find.text(user.email!), findsOneWidget);
    expect(find.text(user.phoneNumber!), findsOneWidget);
    expect(find.text("${user.province!} , ${user.city!}"), findsOneWidget);

    expect(find.byType(ElevatedButton), findsAtLeast(2));
  });
}