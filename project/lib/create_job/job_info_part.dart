import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import 'create_job_text_icon.dart';

class CreateJobInfoPage extends StatelessWidget {
  const CreateJobInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Job Info",leading: (){
        Navigator.of(context).pop();
      },),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20 ,right: 20 , top: 10 , bottom: 20),
              child: CreateJobTextIcon(
                icon: const Icon(Icons.location_on_outlined , size: 24,),
                text: "Location",
                onTapString: "Choose",
                onTap: (){
                },
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CreateJobTextIcon(
                icon: const Icon(Icons.access_time_rounded , size: 24,),
                text: "Time Table",
                onTapString: "Set",
                onTap: (){
                },
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CreateJobTextIcon(
                icon: const Icon(Icons.diamond_outlined , size: 24,),
                text: "Experience",
                onTapString: "Set",
                onTap: (){
                },
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CreateJobTextIcon(
                icon: const Icon(Icons.wallet_outlined , size: 24,),
                text: "Initial cost",
                onTapString: "Set",
                onTap: (){
                },
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CreateJobTextIcon(
                icon: const Icon(Icons.wallet_outlined , size: 24,),
                text: "Approximate cost per hour",
                onTapString: "Set",
                onTap: (){
                },
              ),
            ),
            MyDivider(),
          ],
        ),
      ),
    );
  }
}
