import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/widgets/floating_action_button.dart';

void main(){
  testWidgets("floating action button test", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyFloatingActionButton(onTap: (){}),)
    );

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text("New Job"), findsOneWidget);
  });
}