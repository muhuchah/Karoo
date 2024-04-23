import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/job/job_info.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/job_file.dart';
import '../widgets/job_list_tile.dart';

class DisplayJobPage extends StatelessWidget {
  String title;
  String? subCategory;
  Function()? leadingOnTap;
  Widget? floatingActionButton;
  DisplayJobPage({super.key , required this.title ,
    required this.subCategory , required this.leadingOnTap , this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(),
      body: FutureBuilder(future: subCategory == null ?
        JobRequest.getUserJobs() :
        JobRequest.getJobsBySubCategory(subCategory!),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return getJobs(snapShot.data! , context);
          }
          else if(snapShot.hasError){
            return SizedBox(
              height: 200,
              child: Center(
                child: Text(snapShot.error.toString() ,
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
      floatingActionButton: floatingActionButton,
    );
  }

  PreferredSizeWidget getAppBar(){
    if(leadingOnTap == null){
      return MainAppBar(text: title);
    }
    return SubAppBar(text: title, leading: leadingOnTap!);
  }

  Widget getJobs(List<Job> data , context){
    int length = getCount(data);
    return ListView.builder(
      itemBuilder: (context , index){
        return Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    return JobInfoPage(id : data[index].id!);
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: JobListTile(job : data[index]),
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: AppColor.divider,)
          ],
        );
      },
      itemCount: length,
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
