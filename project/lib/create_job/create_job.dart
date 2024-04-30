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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode categoryFocus = FocusNode();
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
                      getCategoryName(widget.categoryFocus),
                    ],
                  ),
                ),
                const MyDivider(margin: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
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
                        decoration: InputDecoration(hintText: "Job Title" ,
                            labelText: JobData.title == "" ? null : JobData.title,
                            hintStyle:const  TextStyle(color: AppColor.hint,fontSize: 16),
                            border: const UnderlineInputBorder()
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
                          decoration: InputDecoration(hintText: "Description" ,
                            labelText: JobData.description == "" ? null : JobData.description,
                            hintStyle: const TextStyle(color: AppColor.hint,fontSize: 16),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
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
                      if(widget._formKey.currentState!.validate()){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return CreateJobInfoPage();
                        }));
                      }
                      else if(JobData.subCategory == ""){
                        widget.categoryFocus.requestFocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Choose category"),
                            duration: Duration(seconds: 1),)
                        );
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

  Widget getCategoryName(focus){
    return TextButton(
      focusNode: focus,
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
    );
  }

  void mainCategoryOnTap(context , mainCategory){
    Navigator.of(context).push(
      MaterialPageRoute(builder : (context) =>
        SubCategoryPage(mainCategory: mainCategory,
          leading: (){
            Navigator.of(context).pop();
          },
          onTap: (subCategory){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            setState(() {
              JobData.subCategory = subCategory;
            });
          }
        )
      )
    );
  }
}
