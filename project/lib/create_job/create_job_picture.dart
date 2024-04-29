import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/create_job/job_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class CreateJobPicture extends StatefulWidget {
  CreateJobPicture({super.key});

  @override
  State<CreateJobPicture> createState() => _CreateJobPictureState();
}

class _CreateJobPictureState extends State<CreateJobPicture> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getWidgets(),
    );
  }

  List<Widget> _getWidgets(){
    List<Widget> children = [const CustomText(text: "Pictures", size: 16,
        textColor: Colors.black, weight: FontWeight.normal) ,
      const SizedBox(height: 20,)];

    List<Widget> rowChildren = [];
    for(int i=0;i<JobData.images.length;i++){
      rowChildren.add(
        getJobImage(JobData.images[i] , i),
      );

      if((i+1)%3 == 0){
        children.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ));
        children.add(const SizedBox(height: 20,));
        rowChildren = [];
      }
    }

    bool add = true;

    for(int i=JobData.images.length;i<6;i++){
      rowChildren.add(
        getBlankImage(add)
      );

      if((i+1)%3 == 0){
        children.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ));
        children.add(const SizedBox(height: 20,));
        rowChildren = [];
      }

      if(add){
        add = false;
      }
    }

    return children;
  }

  Widget getJobImage(image , index){
    return GestureDetector(
      onTap: (){
        setState(() {
          JobData.images.removeAt(index);
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(image,width: 80,height: 80,fit: BoxFit.fill,),
      ),
    );
  }

  Widget getBlankImage(bool add){
    return GestureDetector(
      onTap: add ? pictureOnTap : null,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.hint
        ),
        child: add ? const Center(child: Icon(Icons.add,color: Colors.white,size: 40,),)
            : null,
      ),
    );
  }

  Future<void> pictureOnTap() async {
    final image =await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      JobData.images.add(File(image!.path));
    });
  }
}
