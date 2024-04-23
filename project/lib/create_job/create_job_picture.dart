import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class CreateJobPicture extends StatelessWidget {
  List<String> images;
  CreateJobPicture({super.key , required this.images});

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
    for(int i=0;i<images.length;i++){
      rowChildren.add(
        getJobImage(images[i]),
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

    for(int i=images.length;i<6;i++){
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

  Widget getJobImage(imageUrl){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(imageUrl,width: 80,height: 80,fit: BoxFit.fill,),
    );
  }

  Widget getBlankImage(bool add){
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.hint
      ),
      child: add ? Center(child: Icon(Icons.add,color: Colors.white,size: 40,),)
          : null,
    );
  }
}
