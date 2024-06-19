import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/user_file.dart';
import 'package:project/search/filter_address.dart';

void main(){
  testWidgets("address filter testing", (tester) async {
    User user = User();
    user.province = "Isfahan";
    user.city = "Isfahan";

    await tester.pumpWidget(MaterialApp(home: FilterAddressPage(),));

    expect(find.byType(CircularProgressIndicator), findsAtLeast(2));
  });
}