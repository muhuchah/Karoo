import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import 'custom_text.dart';

class MyFloatingActionButton extends StatelessWidget {
  Function() onTap;
  MyFloatingActionButton({super.key , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColor.main,
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 20.0 , right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "New Job", size: 20,
                  textColor: AppColor.background, weight: FontWeight.bold),
              Icon(Icons.add , size: 32,color: AppColor.background,)
            ],
          ),
        ),
      ),
    );
  }
}
