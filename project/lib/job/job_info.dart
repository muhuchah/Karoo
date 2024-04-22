import 'package:flutter/material.dart';
import 'package:project/first/first_page_button.dart';
import 'package:project/job/icon_text_button_widget.dart';
import 'package:project/job/icon_text_job_widget.dart';
import 'package:project/job/job_appbar.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

import '../utils/app_color.dart';

class JobInfoPage extends StatelessWidget {
  const JobInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: JobAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomText(text: "Building/plumber", size: 12,
                        textColor: Colors.black, weight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed:(){

                        },
                        icon: Icon(Icons.bookmark_border , size: 24,),
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
                padding:EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "plumber", size: 20,
                                  textColor: Colors.black, weight: FontWeight.bold),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Isfahan , Shahreza" , style: TextStyle(color: AppColor.loginText1,
                                      fontSize: 14 , fontWeight: FontWeight.normal ,
                                      fontStyle: FontStyle.italic),
                                  ),
                                  Row(
                                    children: [
                                      CustomText(text: "4.4", size: 12,
                                          textColor: AppColor.loginText1, weight: FontWeight.normal),
                                      Icon(Icons.star , color: AppColor.loginText1,size: 16,),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    MyDivider(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_outline,size: 24,),
                              const SizedBox(width: 5,),
                              CustomText(text: "Name", size: 16,
                                  textColor: Colors.black, weight: FontWeight.w500),
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
                    MyDivider(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconText(
                        icon: Icon(Icons.diamond_outlined),
                        text: "Experience",
                        info: "2 Year"
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconText(
                          icon: Icon(Icons.wallet_outlined),
                          text: "Initial cost",
                          info: "10 \$"
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconText(
                          icon: Icon(Icons.wallet_outlined),
                          text: "Approximate cost per hour",
                          info: "20 \$"
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconTextButton(
                        icon: Icon(Icons.access_time_outlined),
                        text: "Time Table",
                        textButton:TextButton(
                          onPressed: () {

                          },
                          child: Text("Show"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Description", size: 16,
                              textColor: Colors.black, weight: FontWeight.w500),
                          const SizedBox(height: 10,),
                          CustomText(text: "Description\n-------\n-------\n-------"
                              , size: 16, textColor: Colors.black, weight: FontWeight.normal),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Skill", size: 16,
                              textColor: Colors.black, weight: FontWeight.w500),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.arrow_drop_down),
                              const SizedBox(width: 5,),
                              CustomText(text: "Skill 1", size: 16,
                                  textColor: Colors.black, weight: FontWeight.normal),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.arrow_drop_down),
                              const SizedBox(width: 5,),
                              CustomText(text: "Skill 2", size: 16,
                                  textColor: Colors.black, weight: FontWeight.normal),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconTextButton(
                        text: "Comments",
                        icon: Icon(Icons.comment),
                        textButton: TextButton(
                          onPressed: (){

                          },
                          child: Text("Show All"),
                        ),
                      )
                    ),
                    const SizedBox(height: 10,),
                    MyDivider(),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Good Plumber", size: 16,
                                  textColor: Colors.black, weight: FontWeight.normal),
                              const SizedBox(height: 10,),
                              CustomText(text: "10 days ago", size: 12,
                                  textColor: Colors.black, weight: FontWeight.normal),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        MyDivider(),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Bad Plumber", size: 16,
                                  textColor: Colors.black, weight: FontWeight.normal),
                              const SizedBox(height: 10,),
                              CustomText(text: "20 days ago", size: 12,
                                  textColor: Colors.black, weight: FontWeight.normal),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    MyDivider(),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone_outlined,size: 24,),
                              const SizedBox(width: 5,),
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
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
