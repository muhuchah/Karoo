import 'package:flutter/material.dart';
import 'package:project/profile/delete_account_page.dart';
import 'package:project/profile/profile_list_tile.dart';
import 'package:project/profile/user_info.dart';
import 'package:project/request.dart';
import 'package:project/user/user_file.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';

class ProfilePage extends StatelessWidget {
  final User user = User();
  ProfilePage({super.key});

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
      body: Center(child: user.fullName==null ? FutureBuilder<String>(
          future: Request.personalInformation(),
          builder: (context , snapshot){
            if(snapshot.hasData){
              return getWidgets(context);
            }
            return const CircularProgressIndicator();
          },
        ) : getWidgets(context)
      ),
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
              label: "Address", text: user.address!),
          ProfileListTile(userInfo: UserInfo.password,
            label: "Password", text: user.password! , isPassword: true,),
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
                      var response = await Request.logout();

                      ScaffoldMessenger
                          .of(context)
                          .showSnackBar(
                          SnackBar(content: Text(response),
                            duration: Duration(seconds: 3),))
                          .closed
                          .then((value) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed("/home");
                      });
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString()),
                            duration: Duration(seconds: 3),));
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
                    deleteAccountAlertDialog(context, "Password");
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
}
