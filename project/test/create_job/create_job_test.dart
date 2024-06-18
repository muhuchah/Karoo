import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/create_job/create_job.dart';
import 'package:project/create_job/create_job_buttons.dart';
import 'package:project/create_job/job_data.dart';

void main(){
  testWidgets("create job testing", (tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateJob(),));

    JobData.subCategory = "some category";
    await tester.enterText(find.byKey(const Key("title")), "job title");

    await tester.tap(find.byType(ShortButton));
    await tester.pump();
    
    expect(find.text("title"), findsNothing);
  });
}