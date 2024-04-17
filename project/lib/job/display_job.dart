import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

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

    );
  }
}
