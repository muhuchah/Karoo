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
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: const BigText(text: "Profile",),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.arrow_back_ios , size: 32,)),
        ),
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1,color: AppColor.divider,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            const ProfileListTile(label: "Full Name", text: "Hamid Mehranfar"),
            const ProfileListTile(label: "Email", text: "hhhhaaaa@gmail.com"),
            const ProfileListTile(label: "Phone Number", text: "09904503067"),
            const ProfileListTile(label: "Address", text: "Isfahan,Isfahan"),
            const ProfileListTile(label: "Password", text: "12345678" , isPassword: true,),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: (){

                    }, child: BigText(text: "Logout",size: 20,textColor: Colors.white,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: Size(200, 40,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){

                    }, child: BigText(text: "Delete Account",size: 20,textColor: Colors.white,),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.main,
                          fixedSize: Size(200, 40,),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
