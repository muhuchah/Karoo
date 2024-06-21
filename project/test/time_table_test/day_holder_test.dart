import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/time_table/day_holder.dart';
import 'package:project/time_table/time_table_data.dart';

void main(){
  testWidgets("day holder testing", (tester) async {
    TimeTableData.init();
    TimeTableData.isCreate = true;
    TimeTableData.times["Saturday"]!.add("12:00-14:00");

    await tester.pumpWidget(MaterialApp(
      home: DayHolderWidget(index: 0, text: "Saturday"),)
    );

    expect(find.text("Saturday"), findsOneWidget);
    expect(find.text("12:00-14:00"), findsOneWidget);
    expect(find.text("Add Time"), findsOneWidget);
  });
}