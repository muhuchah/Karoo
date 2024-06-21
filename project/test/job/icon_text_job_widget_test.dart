import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/job/icon_text_job_widget.dart';

void main(){
  testWidgets("icon text testing", (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: IconText(icon: Icon(Icons.add), text: "test", info: "some info"),)
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.text("some info"), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}