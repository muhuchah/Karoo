import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/create_job/create_job_text_icon.dart';

void main(){
  testWidgets("test with text", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CreateJobTextIcon(text: "text",onTapString: "",
        onTap: (){}, icon: const Icon(Icons.add),),
    ));

    expect(find.text("text"), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}