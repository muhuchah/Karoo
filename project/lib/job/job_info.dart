import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/comment/comment_data.dart';
import 'package:project/component/comment_file.dart';
import 'package:project/component/job_file.dart';
import 'package:project/create_job/create_job.dart';
import 'package:project/create_job/job_data.dart';
import 'package:project/first/first_page_button.dart';
import 'package:project/job/icon_text_button_widget.dart';
import 'package:project/job/icon_text_job_widget.dart';
import 'package:project/job/job_widgets.dart';
import 'package:project/request/job_request.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

import '../comment/display_comment.dart';
import '../utils/app_color.dart';

class JobInfoPage extends StatefulWidget {
  int id;
  bool userJob;
  Function? deleteOnTap;
  JobInfoPage({super.key , required this.id , required this.userJob , this.deleteOnTap});

  @override
  State<JobInfoPage> createState() => _JobInfoPageState();
}

class _JobInfoPageState extends State<JobInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: FutureBuilder(
        future: JobRequest.getJobDetail(widget.id),
        builder: (context,snapShot) {
          if(snapShot.hasData){
            return searchUserWidget(context , snapShot.data!);
          }
          else if(snapShot.hasError){
            return SizedBox(
              height: 200,
              child: Center(
                child: Text(snapShot.error.toString() ,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          }
          else{
            return const CircularProgressIndicator();
          }
        },
      )
    );
  }

  Widget searchUserWidget(BuildContext context , Job job){
    return FutureBuilder(
      future: UserRequest.searchUser(job.userEmail!),
      builder: (context,snapShot) {
        if(snapShot.hasData){
          return infoWidget(context , job , snapShot.data!);
        }
        else if(snapShot.hasError){
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(snapShot.error.toString() ,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        else{
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget infoWidget(BuildContext context , Job job , List<String> userValues) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobAppBar(images: job.pictures),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText(
                      text: "${job.mainCategory}/${job.subCategory}",
                      size: 12,
                      textColor: Colors.black,
                      weight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(Icons.bookmark_border, size: 24,),
                    ),
                    IconButton(
                      onPressed: () {

                      },
                      icon: Image.asset(
                        "asset/icons/exclamation-mark.png", width: 24,
                        height: 24,
                        fit: BoxFit.fill,),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          child: CustomText(text: userValues[0], size: 16,
                              textColor: Colors.black, weight: FontWeight
                                  .normal),
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
                        info: JobStrings.getExperience(job)
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
                        info: JobStrings.getInitCost(job)
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
                        info: JobStrings.getCostPerHour(job)
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
                      textButton: TextButton(
                        onPressed: () {

                        },
                        child: const Text("Show"),
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
                        CustomText(
                            text: JobStrings.getDescription(job), size: 16,
                            textColor: Colors.black, weight: FontWeight.normal),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: JobSkills(skills: job.skills!),
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
                          onPressed: () {
                            CommentData.onSubmitTap = (){
                              setState(() {});
                            };
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return DisplayComments(job: job,);
                                }
                              )
                            );
                          },
                          child: const Text("Show All"),
                        ),
                      )
                  ),
                  const SizedBox(height: 10,),
                  const MyDivider(),
                  const SizedBox(height: 20,),
                  JobComments(comments: job.comments!),
                  const SizedBox(height: 20,),
                  const MyDivider(),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.phone_outlined, size: 24,),
                            SizedBox(width: 5,),
                            CustomText(text: "Phone Number",
                                size: 16,
                                textColor: Colors.black,
                                weight: FontWeight.w500),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left: 29),
                          child: CustomText(text: userValues[1], size: 16,
                              textColor: Colors.black, weight: FontWeight
                                  .normal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: getButtons(job , context)
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

  Widget getButtons(Job job , context){
    if(widget.userJob){
      return Column(
        children: [
          FirstPageButton(
            text: "Edit",
            color: AppColor.main,
            onTap: () {
              JobData.setEditValues(job);
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return CreateJob();
              }));
            }
          ),
          const SizedBox(height: 30,),
          FirstPageButton(
            text: "Delete",
            color: AppColor.main,
            onTap: () async {
              await JobRequest.deleteJob(job);
              Navigator.of(context).pop();
              widget.deleteOnTap!();
            }
          ),
        ],
      );
    }
    else{
      return FirstPageButton(
        text: "Chat",
        color: AppColor.main,
        onTap: () {

      });
    }
  }
}
