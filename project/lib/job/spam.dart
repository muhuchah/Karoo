import 'package:flutter/material.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/job_file.dart';
import '../widgets/custom_text.dart';
import '../widgets/long_button.dart';

class SpamPage extends StatefulWidget {
  Job job;
  List<String> reports = [];
  List<bool> selectedReports = [];
  SpamPage({super.key , required this.job}){
    setReports();
  }

  @override
  State<SpamPage> createState() => _SpamPageState();

  void setReports(){
    reports.add("Bad Job");
    reports.add("Very Bad Job");
    reports.add("Very Very Bad Job");
    reports.add("Very Very Very Bad Job");
    reports.add("Very Very Very Very Bad Job");
    reports.add("Very Very Very Very Very Bad Job");

    for(int i=0; i<reports.length;i++){
      selectedReports.add(false);
    }
  }
}

class _SpamPageState extends State<SpamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Report", leading: (){
        Navigator.of(context).pop();
      }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: 
            ListView.separated(
              separatorBuilder: (context , index){
                return const SizedBox(height: 20,);
              },
              padding: const EdgeInsets.all(20),
              itemCount: widget.reports.length,
              itemBuilder: (context , index){
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Checkbox(value: widget.selectedReports[index],
                          onChanged: (value){
                            setState(() {
                              widget.selectedReports[index] = value!;
                            });
                          }
                        ),
                      ),
                      const SizedBox(width: 5,),
                      CustomText(text: widget.reports[index], size: 20,
                          textColor: getTextColor(),
                          weight: FontWeight.normal),
                    ],
                  ),
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20 , right: 20 , top: 20 , bottom: 10),
            child: LongButton(
              onTap:() async {
                for(int i=0;i<widget.selectedReports.length;i++){
                  if(widget.selectedReports[i]){
                    await JobRequest.spam(widget.reports[i], widget.job.id!);
                  }
                }
                Navigator.of(context).pop();
              },
              text: "Save"
            ),
          )
        ],
      ),
    );
  }

  Color getTextColor() {
    return Colors.black;
  }
}
