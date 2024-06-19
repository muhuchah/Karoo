import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/user_file.dart';
import 'package:project/profile/profile_list_tile.dart';
import 'package:project/profile/user_info.dart';

void main(){
  testWidgets("profile tile is testing", (tester) async {
    User user = User();
    user.fullName = "Hamid";

    await tester.pumpWidget(MaterialApp(
      home: ProfileListTile(userInfo: UserInfo.fullName, label: "full name",
        text: user.fullName!, onTap: () {},),)
    );

    expect(find.text("full name"), findsOneWidget);
    expect(find.text(user.fullName!), findsOneWidget);
  });
}