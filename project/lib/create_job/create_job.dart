import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/create_job/create_job_picture.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

class CreateJob extends StatefulWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CreateJob({super.key});

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
                      child:const CustomText(text: "Choose", size: 16,
                          textColor: AppColor.hint, weight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              const MyDivider(margin: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                child: CreateJobPicture(images: [],),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(text: "Job Title", size: 16,
                        textColor: Colors.black, weight: FontWeight.normal),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: const InputDecoration(hintText: "Job Title" ,
                          hintStyle: TextStyle(color: AppColor.hint,fontSize: 16),
                          border: UnderlineInputBorder()
                      ),
                      controller: widget.titleController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(text: "Description", size: 16,
                        textColor: Colors.black, weight: FontWeight.normal),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: const InputDecoration(hintText: "Description" ,
                          hintStyle: TextStyle(color: AppColor.hint,fontSize: 16),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                        ),
                        controller: widget.descriptionController,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20 , top: 30),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(onPressed: (){

                  },
                    child: const BigText(text: "Next",size: 20,textColor: Colors.white,),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: const Size(200, 40,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
