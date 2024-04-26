import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class CreateJobSkillPage extends StatefulWidget {
  String subCategory;
  CreateJobSkillPage({super.key , required this.subCategory});

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
        children: [
          CustomText(text: widget.subCategory, size: 20,
              textColor: AppColor.text1, weight: FontWeight.w500),
          FutureBuilder(future: null, builder: (context , snapShot){
            return CircularProgressIndicator();
          }),
        ],
      )
    );
  }
}
