import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/create_job/job_info_part.dart';

void main(){
  testWidgets("job info part test", (tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateJobInfoPage(),));

    expect(find.text("Location"), findsOneWidget);
    expect(find.text("Time Table"), findsOneWidget);
    expect(find.text("Experience"), findsOneWidget);
    expect(find.text("Initial cost"), findsOneWidget);
    expect(find.text("Approximate cost per hour"), findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}