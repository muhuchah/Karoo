import 'package:flutter/material.dart';
import 'package:project/time_table/time_table_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

import '../widgets/long_button.dart';

class TimePickerHolder extends StatefulWidget {
  String day;
  Function() onTap;
  TimePickerHolder({super.key, required this.onTap, required this.day});

  @override
  State<TimePickerHolder> createState() => _TimePickerHolderState();
}

class _TimePickerHolderState extends State<TimePickerHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Time picker", leading: (){
        TimeTableData.startTime = "";
        TimeTableData.endTime = "";
        Navigator.of(context).pop();
      }),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 100),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 150,
                    child: CustomText(text: "Start time :", size: 20,
                        textColor: Colors.black, weight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () async {
                          TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);
                          final TimeOfDay? startTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                              initialEntryMode: TimePickerEntryMode.dial
                          );

                          if(startTime!=null) {
                            setState(() {
                              TimeTableData.startTime =
                              "${startTime.hour}-${startTime.minute}";
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                        ),
                        child: CustomText(text: TimeTableData.startTime == "" ?
                        "Choose" : TimeTableData.startTime, size: 20,
                            textColor: TimeTableData.startTime == "" ?
                            AppColor.hint : Colors.black, weight: FontWeight.w600),),
                    )
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  const SizedBox(
                    width: 150,
                    child: CustomText(text: "End time :", size: 20,
                        textColor: Colors.black, weight: FontWeight.w600),
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () async {
                            TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);
                            final TimeOfDay? endTime = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                                initialEntryMode: TimePickerEntryMode.dial
                            );

                            if(endTime!=null) {
                              setState(() {
                                TimeTableData.endTime =
                                "${endTime.hour}-${endTime.minute}";
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          child: CustomText(text: TimeTableData.endTime == "" ?
                          "Choose" : TimeTableData.endTime, size: 20,
                              textColor: TimeTableData.endTime == "" ?
                              AppColor.hint : Colors.black, weight: FontWeight.w600),),
                      )
                  )
                ],
              ),
              Expanded(
                child:LongButton(
                  onTap: (){
                    widget.onTap();
                    Navigator.of(context).pop();
                  },
                  text: "Save",
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
