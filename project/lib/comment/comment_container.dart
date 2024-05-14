import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/comment/comment_data.dart';
import 'package:project/component/user_file.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

import '../component/comment_file.dart';
import '../component/job_file.dart';
import 'comment_page.dart';

class CommentTile extends StatelessWidget {
  Comment comment;
  Job? job;
  CommentTile({super.key , required this.comment , this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      User user = User();
                      if(comment.userEmail == user.email){
                        CommentData.id = comment.id!;
                        CommentData.title = comment.title!;
                        CommentData.comment = comment.comment!;
                        CommentData.rating = comment.rating!;
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return CommentPage(job : job! , create: false,);
                          })
                        );
                      }
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 40,
                          child: Row(children: [
                            CustomText(text: comment.rating.toString(), size: 12,
                                textColor: AppColor.loginText1, weight: FontWeight.normal),
                            const SizedBox(width: 2,),
                            const Icon(Icons.star,size: 15,color: AppColor.loginText1,),
                          ],),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(comment.title! , overflow: TextOverflow.ellipsis ,
                            maxLines: 1,style: const TextStyle(fontSize: 16 ,
                              color: Colors.black , fontWeight: FontWeight.w500
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed:(){
                    },
                    icon: Icon(Icons.more_vert , size: 24 , color: Colors.black,)
                  ),
                ],
              ),
              Row(children: [
                const SizedBox(width: 40,),
                CustomText(text: comment.date == null ? "" : comment.date!, size: 12,
                    textColor: AppColor.hint, weight: FontWeight.normal)
              ],),
            ],
          ),
        ),
        const MyDivider(margin: 10,),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: comment.comment!, size: 16,
                  textColor: Colors.black, weight: FontWeight.normal),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      CustomText(text: "1", size: 12,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Image.asset("asset/icons/like.png",width: 13,height: 13,),
                      ),
                      const SizedBox(width: 10,),
                      CustomText(text: "5", size: 12,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Image.asset("asset/icons/dislike.png",width: 13,height: 13,),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const MyDivider(),
      ],
    );
  }
}
