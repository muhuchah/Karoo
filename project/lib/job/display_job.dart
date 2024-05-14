import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/comment/display_comment.dart';
import 'package:project/job/job_info.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/job_file.dart';
import '../create_job/job_data.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/job_list_tile.dart';

class DisplayJobPage extends StatefulWidget {
  String title;
  String? subCategory;
  Function()? leadingOnTap;
  bool floatingActionButton;
  bool userJob;
  DisplayJobPage({super.key , required this.title , required this.subCategory ,
    required this.leadingOnTap , required this.floatingActionButton , required this.userJob});

  @override
  State<DisplayJobPage> createState() => _DisplayJobPageState();
}

class _DisplayJobPageState extends State<DisplayJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(),
      body: FutureBuilder(future: widget.subCategory == null ?
        JobRequest.getUserJobs() :
        JobRequest.getJobsBySubCategory(widget.subCategory!),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return getJobs(snapShot.data! , context);
          }
          else if(snapShot.hasError){
            print(snapShot.error);
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
      floatingActionButton: widget.floatingActionButton ? MyFloatingActionButton(onTap: (){
        JobData.onTap = (job , context){
          setState(() {
            JobData.init();

            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return JobInfoPage(id : job.id! , userJob: true , deleteOnTap: (){
                setState(() {});
              },onTap: (){setState(() {});},);
            }));
          });
        };
        Navigator.of(context).pushNamed("/create_job");
      },) : null
    );
  }

  PreferredSizeWidget getAppBar(){
    if(widget.leadingOnTap == null){
      return MainAppBar(text: widget.title);
    }
    return SubAppBar(text: widget.title, leading: widget.leadingOnTap!);
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
                    if(widget.userJob){
                      JobData.onTap = (job , context){
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return JobInfoPage(id : job.id! , userJob: true,
                              onTap: (){setState(() {});},
                            );
                          }));
                          JobData.init();
                        });
                      };
                    }
                    return JobInfoPage(id : data[index].id! ,
                      userJob: widget.userJob,deleteOnTap: (){
                      setState(() {});
                      },onTap: (){setState(() {});}
                    );
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
