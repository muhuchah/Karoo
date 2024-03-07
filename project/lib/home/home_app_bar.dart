import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Karoo" ,
        style: TextStyle(color: AppColor.background ,
            fontSize: 32 , fontWeight: FontWeight.bold),),
      backgroundColor: AppColor.main,);
  }
}
