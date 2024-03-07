import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    
    AppBar appBar = AppBar(
      title: const BigText(text: "Karoo", textColor: AppColor.background,),
      backgroundColor: AppColor.main,);

    var appBarHeight = appBar.preferredSize.height;
    
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: screenHeight - appBarHeight,
        color: AppColor.main,
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight - appBarHeight - 360,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: AppColor.background,),
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.only(left: 30 , top: 40 , right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BigText(text: "Do Do" , size: 24,),
                    const SizedBox(height: 40,),
                    const BigText(text: "an app to find people to do your work" , size: 20,weight: FontWeight.normal,),
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
              ),
            ),
        ],),
      ),
    );
  }
}
