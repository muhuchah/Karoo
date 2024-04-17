import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

class DisplayJob extends StatelessWidget {
  String text;
  Function() leadingOnTap;
  DisplayJob({super.key , required this.text , required this.leadingOnTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: text,leading: leadingOnTap,),
      body:
    );
  }
}
