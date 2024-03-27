import 'package:flutter/material.dart';
import 'package:project/profile/profile_list_tile.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(text: "Profile",),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.arrow_back_ios , size: 32,)),
        ),
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1,color: AppColor.divider,),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: CustomText(
              text: "Personal Information",
              size: 20,
              textColor: AppColor.text1,
              weight: FontWeight.w500,
            ),
          ),
          Container(height: 1,color: AppColor.divider,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
          ProfileListTile(label: "Full Name", text: "Hamid Mehranfar"),
        ],
      ),
    );
  }
}
