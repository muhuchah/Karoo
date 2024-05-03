import 'package:flutter/material.dart';
import 'package:project/comment/comment_container.dart';
import 'package:project/comment/comment_page.dart';
import 'package:project/component/job_file.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class DisplayComments extends StatelessWidget {
  Job job;
  DisplayComments({super.key , required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Comments", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height-180,
            child: ListView.builder(
              itemBuilder: (context , index){
                return CommentTile(title: "Good", comment: "Good plumber",
                    rating: 2 , date: "10 days ago",);
              },
              itemCount: 10),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return CommentPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.main,
                  fixedSize: const Size(160, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Row(
                  children: [
                    CustomText(text: "Comment", size: 16,
                        textColor: AppColor.background, weight: FontWeight.bold),
                    SizedBox(width: 10,),
                    Icon(Icons.add_comment_rounded , size: 28,color: AppColor.background,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}