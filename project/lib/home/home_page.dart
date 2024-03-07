import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    
    AppBar appBar = AppBar(
      title: const Text("Karoo" ,
        style: TextStyle(color: AppColor.background ,
            fontSize: 32 , fontWeight: FontWeight.bold),),
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
              child: Column(children: [],),
              ),
          ),
        ],),
      ),
    );
  }
}
