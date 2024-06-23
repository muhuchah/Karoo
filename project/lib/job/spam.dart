import 'package:flutter/material.dart';
import 'package:project/request/support_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/job_file.dart';
import '../widgets/custom_text.dart';
import '../widgets/long_button.dart';

class SpamPage extends StatefulWidget {
  Job job;
  SpamPage({super.key , required this.job});

  @override
  State<SpamPage> createState() => _SpamPageState();
}

class _SpamPageState extends State<SpamPage> {
  List<String> reports = [];
  List<bool> selectedReports = [];

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
              itemCount: reports.length,
              itemBuilder: (context , index){
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Checkbox(value: selectedReports[index],
                          onChanged: (value){
                            setState(() {
                              selectedReports[index] = value!;
                            });
                          }
                        ),
                      ),
                      const SizedBox(width: 5,),
                      CustomText(text: reports[index], size: 20,
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
                for(int i=0;i<selectedReports.length;i++){
                  if(selectedReports[i]){
                    await SupportRequest.spam(reports[i], widget.job.id!);
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

  @override
  void initState() {
    super.initState();

    reports.add("Unwanted Promotion");
    reports.add("Phishing or Fraud");
    reports.add("Harassment or Bullying");
    reports.add("Malware or Viruses");
    reports.add("Impersonation");
    reports.add("Scam");
    reports.add("Explicit Content");
    reports.add("Misleading Information");
    reports.add("Spam");
    reports.add("Other");

    for(int i=0; i<reports.length;i++){
      selectedReports.add(false);
    }
  }
}
