import 'package:flutter/material.dart';
import 'package:project/component/job_file.dart';
import 'package:project/create_job/create_job_location.dart';
import 'package:project/create_job/create_job_skill.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import 'create_job_buttons.dart';
import 'create_job_text_icon.dart';
import 'job_data.dart';

enum _InfoValue{
  location , experience , initCost , costPerHour
}

class CreateJobInfoPage extends StatefulWidget {
  Color? locationColor;
  Color? experienceColor;
  Color? initialCostColor;
  Color? hourCostColor;
  CreateJobInfoPage({super.key});

  @override
  State<CreateJobInfoPage> createState() => _CreateJobInfoPageState();
}

class _CreateJobInfoPageState extends State<CreateJobInfoPage> {
  @override
  Widget build(BuildContext context) {
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
                    onTapString: getValue(_InfoValue.location),
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
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.access_time_rounded , size: 24,),
                    text: "Time Table",
                    onTapString: "Set",
                    onTap: (){
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.diamond_outlined , size: 24,),
                    onTapColor: widget.experienceColor,
                    text: "Experience",
                    onTapString: getValue(_InfoValue.experience),
                    onTap: (){
                      _showDialog("Experience", (value){
                        setState(() {
                          JobData.experience = value;
                        });
                      });
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.wallet_outlined , size: 24,),
                    onTapColor: widget.initialCostColor,
                    text: "Initial cost",
                    onTapString: getValue(_InfoValue.initCost),
                    onTap: (){
                      _showDialog("initial cost", (value){
                        setState(() {
                          JobData.initialCost = value;
                        });
                      });
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.wallet_outlined , size: 24,),
                    onTapColor: widget.hourCostColor,
                    text: "Approximate cost per hour",
                    onTapString: getValue(_InfoValue.costPerHour),
                    onTap: (){
                      _showDialog("approximate cost per hour", (value){
                        setState(() {
                          JobData.costPerHour = value;
                        });
                      });
                    },
                  ),
                ),
                MyDivider(),
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
                                        subCategory: "Plumber",
                                        preSkills : JobData.skills,
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
                    child: ShortButton(text:"Next",onTap: () async {
                      try {
                        Job job = await JobRequest.createJob();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        JobData.createOnTap;
                        print("Yessss");
                      }
                      catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString()),
                              duration: const Duration(seconds: 2),));
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

  String getValue(infoValue){
    if(infoValue == _InfoValue.location) {
      if (JobData.province == "") {
        return "Choose";
      }
      widget.locationColor = AppColor.loginText1;
      return JobData.city;
    }

    else if(infoValue == _InfoValue.experience) {
      if (JobData.experience == "") {
        return "Set";
      }
      widget.experienceColor = AppColor.loginText1;
      return JobData.experience;
    }

    else if(infoValue == _InfoValue.initCost) {
      if (JobData.initialCost == "") {
        return "Set";
      }
      widget.initialCostColor = AppColor.loginText1;
      return "${JobData.initialCost} \$";
    }

    if(infoValue == _InfoValue.costPerHour) {
      if (JobData.costPerHour == "") {
        return "Set";
      }
      widget.hourCostColor = AppColor.loginText1;
      return "${JobData.costPerHour} \$";
    }
    return "";
  }

  List<Widget> _getSkills(){
    List<Widget> children = [];
    for(int i=0;i<JobData.skills.length;i++){
      children.add(
        CreateJobTextIcon(icon: null,
          assetPath: "asset/icons/arrow_drop_forward.png", text: JobData.skills[i],
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
