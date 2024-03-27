import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Profile",),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(Icons.arrow_back_ios,size: 32,),
        ),
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1,color: AppColor.divider,),
        ),
      )
    );
  }
}
