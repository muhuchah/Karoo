import 'package:flutter/material.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/skill_file.dart';
import '../widgets/long_button.dart';

class CreateJobSkillPage extends StatefulWidget {
  String subCategory;
  List<Skill>? skills;
  List<Skill> preSkills;
  List<bool>? selectedSkills;
  Function(List<Skill> skills) onTap;
  CreateJobSkillPage({super.key , required this.subCategory ,
    required this.preSkills , required this.onTap});

  @override
  State<CreateJobSkillPage> createState() => _CreateJobSkillPageState();
}

class _CreateJobSkillPageState extends State<CreateJobSkillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Skills", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomText(text: widget.subCategory, size: 20,
                textColor: AppColor.text1, weight: FontWeight.w500),
          ),
          const MyDivider(margin: 10,),
          FutureBuilder(future: JobRequest.getSkills(),
            builder: (context , snapShot){
              if(snapShot.hasData){
                widget.skills = snapShot.data;
                initializeSelected();
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context , index){
                      return const SizedBox(height: 20,);
                    },
                    padding: const EdgeInsets.all(20),
                    itemCount: widget.skills!.length,
                    itemBuilder: (context , index){
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(value: widget.selectedSkills![index],
                                onChanged: (value){
                                  setState(() {
                                    widget.selectedSkills![index] = value!;
                                  });
                                }
                              ),
                            ),
                            const SizedBox(width: 5,),
                            CustomText(text: widget.skills![index].title, size: 16,
                              textColor: getTextColor(widget.selectedSkills![index]),
                              weight: FontWeight.normal),
                          ],
                        ),
                      );
                    }
                  ),
                );
              }
              else if(snapShot.hasError){
                return SizedBox(
                  height: 200,
                  child: Center(child: Text(snapShot.error.toString() ,
                    style: const TextStyle(fontSize: 20),),
                  ),
                );
              }
              return const CircularProgressIndicator();
            }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20 , right: 20 , top: 20 , bottom: 10),
              child: LongButton(
                onTap:(){
                  widget.onTap(_getSkills());
                  Navigator.of(context).pop();
                },
                text: "Save"
              ),
            ),
          )
        ],
      )
    );
  }

  List<Skill> _getSkills(){
    List<Skill> skills = [];
    for(int i = 0;i<widget.selectedSkills!.length;i++){
      if(widget.selectedSkills![i]){
        skills.add(widget.skills![i]);
      }
    }
    return skills;
  }
  
  void initializeSelected(){
    if(widget.selectedSkills == null) {
      widget.selectedSkills = [];
      for (int i = 0; i < widget.skills!.length; i++) {
        if(widget.preSkills.contains(widget.skills![i])){
          widget.selectedSkills!.add(true);
        }
        else {
          widget.selectedSkills!.add(false);
        }
      }
    }
  }

  Color getTextColor(value){
    if(value){
      return AppColor.loginText1;
    }
    return Colors.black;
  }
}
