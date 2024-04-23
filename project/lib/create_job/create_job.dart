import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

class CreateJob extends StatelessWidget {
  const CreateJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "New Job",leading: (){

      },),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Category", size: 16,
                        textColor: Colors.black, weight: FontWeight.normal),
                    TextButton(
                      onPressed: (){

                      },
                      child:const CustomText(text: "choose", size: 16,
                          textColor: AppColor.hint, weight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              const MyDivider(margin: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
