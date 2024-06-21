import 'package:flutter/material.dart';
import 'package:project/create_job/job_data.dart';
import 'package:project/time_table/day_holder.dart';
import 'package:project/time_table/time_table_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/long_button.dart';
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
          children: getChildren(),
        ),
      ),
    );
  }

  List<Widget> getChildren(){
    List<Widget> children = [
      DayHolderWidget(index:0, text: "Saturday"),
      DayHolderWidget(index:1, text: "Sunday"),
      DayHolderWidget(index:2, text: "Monday"),
      DayHolderWidget(index:3, text: "Tuesday"),
      DayHolderWidget(index:4, text: "Wednesday"),
      DayHolderWidget(index:5, text: "Thursday"),
      DayHolderWidget(index:6, text: "Friday"),
      const SizedBox(height: 30,)
    ];

    if(TimeTableData.isCreate){
      children.add(
        Padding(
          padding: const EdgeInsets.all(20),
          child: LongButton(
            onTap: () async {
              try{
                JobData.timeTable = true;
                TimeTableData.onTap!();
                Navigator.of(context).pop();
              }
              catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()),
                    duration: const Duration(seconds: 2),)
                );
              }
            },
            text:"Save"
          ),
        )
      );
    }

    return children;
  }

  @override
  void initState() {
    super.initState();
    if(TimeTableData.selectedValues.isEmpty) {
      TimeTableData.init();
    }
  }
}
