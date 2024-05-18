import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/category/main_category.dart';
import 'package:project/create_job/create_job_buttons.dart';
import 'package:project/create_job/create_job_picture.dart';
import 'package:project/create_job/job_info_part.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import '../category/sub_category.dart';
import 'job_data.dart';

class CreateJob extends StatefulWidget {
  TextEditingController titleController = TextEditingController(
    text: JobData.title,
  );
  TextEditingController descriptionController = TextEditingController(
    text : JobData.description == "" ? null : JobData.description,
  );
  FocusNode titleFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
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
        JobData.init();
        Navigator.of(context).pop();
      },),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: widget._formKey,
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
                      getCategoryName(),
                    ],
                  ),
                ),
                const MyDivider(margin: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                  child: CreateJobPicture(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Job Title", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Job Title" ,
                            hintStyle: TextStyle(color: AppColor.hint,fontSize: 16),
                            border: UnderlineInputBorder(),
                        ),
                        controller: widget.titleController,
                        focusNode: widget.titleFocus,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Please enter title";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
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
                    child: ShortButton(text:"Next",onTap: (){
                      if(JobData.subCategory == ""){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please choose category"),
                              duration: Duration(seconds: 1),)
                        );
                      }
                      else if(widget._formKey.currentState!.validate()){
                        JobData.title = widget.titleController.text;
                        JobData.description = widget.descriptionController.text;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return CreateJobInfoPage();
                        }));
                      }
                      else if(JobData.title == ""){
                        widget.titleFocus.requestFocus();
                      }
                    },)
                  ),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategoryName(){
    return SizedBox(
      width: 200,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainCategoriesPage(
                onTap: (mainCategory){
                  mainCategoryOnTap(context, mainCategory);
                },
                appBar: SubAppBar(text: "Category", leading: () {
                  Navigator.of(context).pop();
                },),
              ),)
            );
          },
          child:Text(JobData.subCategory == "" ? "Choose" : JobData.subCategory,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16 ,
              color: JobData.subCategory == "" ? AppColor.hint : AppColor.loginText1,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void mainCategoryOnTap(context , mainCategory){
    Navigator.of(context).push(
      MaterialPageRoute(builder : (context) =>
        SubCategoryPage(mainCategory: mainCategory,
          leading: (){
            Navigator.of(context).pop();
          },
          onTap: (subCategory , id){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            setState(() {
              JobData.subCategory = subCategory;
              JobData.subCategoryId = id;
            });
          }
        )
      )
    );
  }
}
