import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/profile/delete_account_page.dart';
import 'package:project/profile/profile_list_tile.dart';
import 'package:project/profile/user_info.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/component/user_file.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class ProfilePage extends StatelessWidget {
  final User user = User();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Profile",leading: (){
        Navigator.of(context).pop();
      },),
      body: getWidgets(context),
    );
  }

  Widget getWidgets(BuildContext context){
    return SingleChildScrollView(
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
          ProfileListTile(userInfo:UserInfo.fullName ,
              label: "Full Name", text: user.fullName!),
          ProfileListTile(userInfo: UserInfo.email,
          label: "Email", text: user.email!),
          ProfileListTile(userInfo: UserInfo.phoneNumber,
              label: "Phone Number", text: user.phoneNumber!),
          ProfileListTile(userInfo: UserInfo.address,
              label: "Address", text: "${user.province} , ${user.city}"),
          const ProfileListTile(userInfo: UserInfo.password,
            label: "Password", text: "********"),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () async {
                    try {
                      var response = await UserRequest.logout();
                      _writeBlank();

                      ScaffoldMessenger
                          .of(context)
                          .showSnackBar(SnackBar(content: Text(response),
                            duration: Duration(seconds: 1),))
                          .closed.then((value) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed("/first");
                      });
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString()),
                            duration: Duration(seconds: 1),));
                    }
                  },
                    child: BigText(text: "Logout",size: 20,textColor: Colors.white,),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: const Size(200, 40,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    deleteAccountAlertDialog(context, "Password",_writeBlank());
                  },
                    child: BigText(text: "Delete Account",size: 20,textColor: Colors.white,),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: const Size(200, 40,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _writeBlank() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString("");
  }
}
