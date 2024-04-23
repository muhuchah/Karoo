import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

class JobInfoPage extends StatelessWidget {
  const JobInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Job Info",leading: (){
        Navigator.of(context).pop();
      },),
    );
  }
}
