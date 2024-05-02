import 'package:flutter/material.dart';
import 'package:project/component/comment_file.dart';
import 'package:project/component/job_file.dart';
import 'package:project/first/first_page_button.dart';
import 'package:project/job/icon_text_button_widget.dart';
import 'package:project/job/icon_text_job_widget.dart';
import 'package:project/job/job_widgets.dart';
import 'package:project/request/job_request.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

import '../utils/app_color.dart';

class JobInfoPage extends StatelessWidget {
  int id;
  JobInfoPage({super.key , required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: FutureBuilder(
        future: JobRequest.getJobDetail(id),
        builder: (context,snapShot) {
          if(snapShot.hasData){
            return infoWidget(context , snapShot.data!);
          }
          else if(snapShot.hasError){
            return SizedBox(
              height: 200,
              child: Center(
                child: Text(snapShot.error.toString() ,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }

  Widget infoWidget(BuildContext context , Job job){
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobAppBar(imageUrl : job.picture!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText(text: "${job.mainCategory}/${job.subCategory}",
                      size: 12, textColor: Colors.black, weight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed:(){

                      },
                      icon: const Icon(Icons.bookmark_border , size: 24,),
                    ),
                    IconButton(
                      onPressed:(){

                      },
                      icon: Image.asset("asset/icons/exclamation-mark.png",width: 24,height: 24,fit: BoxFit.fill,),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30,),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JobUserName(title: job.title!,
                    address: "${job.province} , ${job.city}",
                    rating: 4.4,),
                  const SizedBox(height: 15,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconText(
                              icon: const Icon(Icons.person_outlined),
                              text: "Name",
                              info: ""
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left: 29),
                          child: CustomText(text: "Hamid Mehranfar", size: 16,
                              textColor: Colors.black, weight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconText(
                        icon: const Icon(Icons.diamond_outlined),
                        text: "Experience",
                        info: "${job.experience!} Year"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconText(
                        icon: const Icon(Icons.wallet_outlined),
                        text: "Initial cost",
                        info: "${job.initialCost} \$"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconText(
                        icon: const Icon(Icons.wallet_outlined),
                        text: "Approximate cost per hour",
                        info: "${job.costPerHour} \$"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconTextButton(
                      icon: const Icon(Icons.access_time_outlined),
                      text: "Time Table",
                      textButton:TextButton(
                        onPressed: () {

                        },
                        child: Text("Show"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(text: "Description", size: 16,
                            textColor: Colors.black, weight: FontWeight.w500),
                        const SizedBox(height: 10,),
                        CustomText(text: job.description!, size: 16,
                            textColor: Colors.black, weight: FontWeight.normal),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: JobSkills(skills: []),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconTextButton(
                        text: "Comments",
                        icon: const Icon(Icons.comment),
                        textButton: TextButton(
                          onPressed: (){

                          },
                          child: Text("Show All"),
                        ),
                      )
                  ),
                  const SizedBox(height: 10,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  JobComments(comments: []),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.phone_outlined,size: 24,),
                            SizedBox(width: 5,),
                            CustomText(text: "Phone Number", size: 16,
                                textColor: Colors.black, weight: FontWeight.w500),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left: 29),
                          child: CustomText(text: "09904503067", size: 16,
                              textColor: Colors.black, weight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: FirstPageButton(
                        text: "Chat",
                        color: AppColor.main,
                        onTap:(){

                        }
                    ),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
