import 'package:flutter/material.dart';
import 'package:project/component/comment_file.dart';

import '../utils/app_color.dart';
import '../widgets/custom_text.dart';
import '../widgets/divider.dart';

class JobAppBar extends StatelessWidget{
  String? imageUrl;
  JobAppBar({super.key , required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        getImage(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0 , top: 8),
          child: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios , size: 28,),
          ),
        ),
      ],
    );
  }

  Widget getImage(){
    if(imageUrl == null){
      return Image.asset("asset/plumber.jpg",
        height: 240,width: double.infinity,fit: BoxFit.fill,);
    }
    return Image.network(imageUrl!,
      height: 240,width: double.infinity,fit: BoxFit.fill,);
  }
}

class JobUserName extends StatelessWidget{
  String title;
  String address;
  double rating;
  JobUserName({super.key , required this.title ,
    required this.address , required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: title, size: 20,
                  textColor: Colors.black, weight: FontWeight.bold),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(address , style: const TextStyle(color: AppColor.loginText1,
                      fontSize: 14 , fontWeight: FontWeight.normal ,
                      fontStyle: FontStyle.italic),
                  ),
                  Row(
                    children: [
                      CustomText(text: rating.toString(), size: 12,
                          textColor: AppColor.loginText1, weight: FontWeight.normal),
                      const Icon(Icons.star , color: AppColor.loginText1,size: 16,),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class JobSkills extends StatelessWidget{
  List<String> skills;

  JobSkills({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getWidgets(),
    );
  }

  List<Widget> _getWidgets(){
    List<Widget> children = [
      const CustomText(text: "Skills", size: 16,
          textColor: Colors.black, weight: FontWeight.w500),
      const SizedBox(height: 10,),
    ];

    for(int i=0;i<skills.length;i++){
      children.add(
        Row(
          children: [
            Image.asset("asset/icons/arrow_drop_forward.png"),
            const SizedBox(width: 5,),
            CustomText(text: skills[i], size: 16,
                textColor: Colors.black, weight: FontWeight.normal),
          ],
        ),
      );
      children.add(const SizedBox(height: 10,),);
    }
    return children;
  }
}

class JobComments extends StatelessWidget {
  List<Comment> comments;
  JobComments({super.key , required this.comments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getWidgets()
    );
  }

  int _getSize(){
    if(comments.length<10){
      return comments.length;
    }
    return 10;
  }

  List<Widget> _getWidgets(){
    List<Widget> children = [];
    int length = _getSize();
    for(int i=0;i<length;i++){
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: comments[i].comment!, size: 16,
                  textColor: Colors.black, weight: FontWeight.normal),
              const SizedBox(height: 10,),
              CustomText(text: comments[i].time!, size: 12,
                  textColor: Colors.black, weight: FontWeight.normal),
            ],
          ),
        ),
      );
      if(i!=length-1){
        children.add(const SizedBox(height: 20,));
        children.add(const MyDivider());
        children.add(const SizedBox(height: 20,));
      }
    }
    return children;
  }
}

