import 'package:flutter/material.dart';
import 'package:project/component/job_file.dart';
import 'package:project/create_job/create_job_location.dart';
import 'package:project/create_job/create_job_skill.dart';
import 'package:project/job/job_info.dart';
import 'package:project/request/job_request.dart';
import 'package:project/time_table/time_table.dart';
import 'package:project/time_table/time_table_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import 'create_job_buttons.dart';
import 'create_job_text_icon.dart';
import 'job_data.dart';

class CreateJobInfoPage extends StatefulWidget {
  Color? locationColor;
  Color? experienceColor;
  Color? initialCostColor;
  Color? hourCostColor;
  String? locationText;
  String? experienceText;
  String? initialCostText;
  String? hourCostText;
  CreateJobInfoPage({super.key});

  @override
  State<CreateJobInfoPage> createState() => _CreateJobInfoPageState();
}

class _CreateJobInfoPageState extends State<CreateJobInfoPage> {
  @override
  Widget build(BuildContext context) {
    _setValue();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Job Info",leading: (){
        Navigator.of(context).pop();
      },),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20 ,right: 20 , top: 10 , bottom: 20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.location_on_outlined , size: 24,),
                    text: "Location",
                    onTapString: widget.locationText,
                    onTapColor: widget.locationColor,
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return CreateJobLocationPage(
                            onTap: (province , city) {
                              setState(() {
                                JobData.province = province;
                                JobData.city = city;
                              });
                            },
                          );
                        })
                      );
                    },
                  ),
                ),
                const MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.access_time_rounded , size: 24,),
                    text: "Time Table",
                    onTapString: "Set",
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return TimeTablePage(isCreate: true,);
                      }));
                    },
                  ),
                ),
                const MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.diamond_outlined , size: 24,),
                    onTapColor: widget.experienceColor,
                    text: "Experience",
                    onTapString: widget.experienceText,
                    onTap: (){
                      _showDialog("Experience", (value){
                        setState(() {
                          JobData.experience = value;
                        });
                      });
                    },
                  ),
                ),
                const MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.wallet_outlined , size: 24,),
                    onTapColor: widget.initialCostColor,
                    text: "Initial cost",
                    onTapString: widget.initialCostText,
                    onTap: (){
                      _showDialog("initial cost", (value){
                        setState(() {
                          JobData.initialCost = value;
                        });
                      });
                    },
                  ),
                ),
                const MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.wallet_outlined , size: 24,),
                    onTapColor: widget.hourCostColor,
                    text: "Approximate cost per hour",
                    onTapString: widget.hourCostText,
                    onTap: (){
                      _showDialog("approximate cost per hour", (value){
                        setState(() {
                          JobData.costPerHour = value;
                        });
                      });
                    },
                  ),
                ),
                const MyDivider(),
                Padding(
                  padding:const EdgeInsets.only(top: 25 , bottom: 10 , left: 20 , right: 20),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Skills", size: 20,
                              textColor: AppColor.loginText1, weight: FontWeight.bold),
                          SizedBox(
                            width: 80,
                            child: Align(
                              alignment: Alignment.center,
                              child:IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context){
                                      return CreateJobSkillPage(
                                        subCategory: JobData.subCategory,
                                        onTap: (skills){
                                          setState(() {
                                            JobData.skills = skills;
                                          });
                                        },
                                      );
                                    })
                                  );
                                },
                                icon: const Icon(Icons.add , size: 24 , color: AppColor.loginText1,)
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Column(
                    children: _getSkills(),
                  ),
                ),
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ShortButton(text:"Save",onTap: () async {
                      if(JobData.province == ""){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please choose province"),
                              duration: Duration(seconds: 1),)
                        );
                      }
                      else{
                        try {
                          Job job;
                          if(JobData.isCreate) {
                            job = await JobRequest.createJob();
                            await sendImages(job.id!);

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            JobData.onTap!(job , context);
                          }
                          else{
                            job = await JobRequest.editJob(JobData.job!);
                            await editImagesRequest(job);

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            JobData.onTap!(job , context);
                          }
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: const Duration(seconds: 2),));
                        }
                      }
                    },)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setValue(){
    if (JobData.province == "") {
      widget.locationText = "Choose";
    }
    else {
      widget.locationColor = AppColor.loginText1;
      widget.locationText = JobData.city;
    }

    if (JobData.experience == "") {
      widget.experienceText = "Set";
    }
    else {
      widget.experienceColor = AppColor.loginText1;
      widget.experienceText = "${JobData.experience} years";
    }

    if (JobData.initialCost == "") {
      widget.initialCostText = "Set";
    }
    else {
      widget.initialCostColor = AppColor.loginText1;
      widget.initialCostText = "${JobData.initialCost} \$";
    }

    if (JobData.costPerHour == "") {
      widget.hourCostText = "Set";
    }
    else {
      widget.hourCostColor = AppColor.loginText1;
      widget.hourCostText = "${JobData.costPerHour} \$";
    }
  }

  List<Widget> _getSkills(){
    List<Widget> children = [];
    for(int i=0;i<JobData.skills.length;i++){
      children.add(
        CreateJobTextIcon(icon: null,
          assetPath: "asset/icons/arrow_drop_forward.png", text: JobData.skills[i].title,
          onTapAssetPath: "asset/icons/multiply.svg", onTap: (){
            setState(() {
              JobData.skills.removeAt(i);
            });
          }
        )
      );
      children.add(const SizedBox(height: 10,));
    }
    return children;
  }

  Future<void> sendImages(int id) async {
    if(JobData.images.isNotEmpty){
      for(int i =0;i<JobData.images.length;i++){
        await JobRequest.createJobPicture(JobData.images[i],id);
      }
    }
  }

  Future<void> editImagesRequest(Job job) async{
    if(JobData.readImages.length < job.pictures!.length){
      for(int i =0;i<job.pictures!.length;i++){
        bool check = false;
        for(int j =0;j<JobData.readImages.length;j++){
          if(job.pictures![i].id == JobData.readImages[j].id){
            check = true;
            break;
          }
        }
        if(!check){
          await JobRequest.deleteJobPicture(job.pictures![i]);
        }
      }
    }

    await sendImages(job.id!);
  }

  void _showDialog(text , Function(String value) onTap){
    FocusNode focusNode = FocusNode();
    showDialog(context: context, builder: (context){
      TextEditingController controller = TextEditingController();
      return AlertDialog(
        title: Text("Enter $text :"),
        content: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
        ),
        actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        },
        child: const Text("Cancel")),
        TextButton(onPressed: () async {
          if (controller.text == "") {
            focusNode.requestFocus();
          }
          onTap(controller.text);
          Navigator.of(context).pop();
        }, child: const Text("Save")),
        ],
      );
    });
  }
}
