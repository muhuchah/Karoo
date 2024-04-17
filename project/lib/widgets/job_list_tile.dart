import 'package:flutter/material.dart';
import 'package:project/component/job_file.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class JobListTile extends StatelessWidget {
  Job job;
  JobListTile({super.key , required this.job});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: job.title!, size: 20,
                  textColor: Colors.black, weight: FontWeight.bold),
              const SizedBox(height: 20,),
              CustomText(text: job.description!, size: 14,
                  textColor: Colors.black, weight: FontWeight.normal),
              const SizedBox(height: 20,),
              Text("Isfahan , Shahreza" , style: TextStyle(color: AppColor.loginText1,
                  fontSize: 14 , fontWeight: FontWeight.normal ,
                  fontStyle: FontStyle.italic),
              ),
          ],),
        ),
        SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(job.picture!,
                  fit: BoxFit.fitHeight,width: 150,height: 100,),
              ),
              const SizedBox(height: 2,),
              Row(children: [
                CustomText(text: "4.4", size: 12,
                    textColor: AppColor.loginText1, weight: FontWeight.normal),
                Icon(Icons.star , color: AppColor.loginText1,size: 16,),
              ],),
            ],
          ),
        ),
      ],
    );
  }
}
