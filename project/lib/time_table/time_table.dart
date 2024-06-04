import 'package:flutter/material.dart';
import 'package:project/time_table/day_holder.dart';
import 'package:project/time_table/time_table_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Time Table", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DayHolderWidget(index:0, text: "Saturday"),
            DayHolderWidget(index:1, text: "Sunday"),
            DayHolderWidget(index:2, text: "Monday"),
            DayHolderWidget(index:3, text: "Tuesday"),
            DayHolderWidget(index:4, text: "Wednesday"),
            DayHolderWidget(index:5, text: "Thursday"),
            DayHolderWidget(index:6, text: "Friday"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    TimeTableData.init();
    TimeTableData.onTap = (){
      setState(() {});
    };
  }
}
