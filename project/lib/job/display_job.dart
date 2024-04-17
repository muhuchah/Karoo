import 'package:flutter/material.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/job_file.dart';

class DisplayJobPage extends StatelessWidget {
  String title;
  String subCategory;
  Function() leadingOnTap;
  DisplayJobPage({super.key , required this.title ,
    required this.subCategory , required this.leadingOnTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: title,leading: leadingOnTap,),
      body: FutureBuilder(future: JobRequest.getJobsBySubCategory(subCategory),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return getJobs(snapShot.data! , context);
          }
          else if(snapShot.hasError){
            return SizedBox(
              height: 200,
              child: Center(child: Text(snapShot.error.toString() ,
                style: TextStyle(fontSize: 20),
              ),
              ),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget getJobs(List<Job> data , context){
    int length = getCount(data);
    return ListView.builder(
      itemBuilder: (context , index){
        if(index == length){
          return Text("End");
        }
        else{

        }
      },
      itemCount: length+1,
    );
  }

  int getCount(List<Job> data){
    if(data.length>10){
      return 10;
    }
    else {
      return data.length;
    }
  }
}
