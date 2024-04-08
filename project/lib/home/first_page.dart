import 'package:flutter/material.dart';
import 'package:project/home/first_page_button.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const BigText(text: "Karoo", textColor: AppColor.background,),
        backgroundColor: AppColor.main,),
      body: Container(
        height: double.infinity,
        color: AppColor.main,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 280),
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)),
              color: AppColor.background,),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30 , top: 40 , right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Do Do" , size: 24,),
                  SizedBox(height: 30,),
                  BigText(text: "an app to find people to do your work" , size: 20,weight: FontWeight.normal,),
                  SizedBox(height: 100,),
                  FirstPageButton(text : "Log in",color: AppColor.button1,
                    onTap: (){
                      Navigator.of(context).pushNamed("/login");
                    },),
                  SizedBox(height: 15,),
                  FirstPageButton(text: "Sign in",color: AppColor.button1,
                    onTap: (){
                      Navigator.of(context).pushNamed("/signup");
                    },)
                ],
              ),
            ),
            ),
          ),
      ),
    );
  }
}
