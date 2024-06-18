import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/edit_info/edit_pages.dart';
import 'package:project/widgets/long_button.dart';

void main(){
  testWidgets("edit pages test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EditPages(text: "Email", hint: "Email@gmail.com", bodyParam: "",
        appBar: "Change Email", assetPath: "asset/icons/email.svg", onTap: () {},
      ),)
    );

    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Change Email"), findsOneWidget);
    expect(find.byType(LongButton), findsOneWidget);
    await tester.enterText(find.byType(TextFormField),"some text");
  });
}