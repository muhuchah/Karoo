import 'package:flutter/material.dart';
import 'package:project/create_job/create_job_picture.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                child: CreateJobPicture(images: [],),
              )
            ],
          ),
        ),
      ),
    );
  }
}
