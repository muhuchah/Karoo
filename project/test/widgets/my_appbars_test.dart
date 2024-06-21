import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/widgets/my_appbars.dart';

void main(){
  group("my appbar test", ()
  {
    testWidgets("main appbar testing", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MainAppBar(text: "main appbar"),))
      ;

      expect(find.text("main appbar"), findsOneWidget);
    });

    testWidgets("sub appbar testing", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SubAppBar(text: "sub appbar", leading: () {}),
      ));

      expect(find.text("sub appbar"), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });
  });
}