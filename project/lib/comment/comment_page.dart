import 'package:flutter/material.dart';
import 'package:project/comment/comment_data.dart';
import 'package:project/request/job_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/long_button.dart';
import 'package:project/widgets/my_appbars.dart';

import '../component/job_file.dart';
import '../first/first_page_button.dart';
import '../widgets/custom_text.dart';

class CommentPage extends StatefulWidget {
  Job job;
  bool create;
  TextEditingController titleController = TextEditingController(
    text: CommentData.title
  );
  TextEditingController commentController = TextEditingController(
    text: CommentData.comment
  );
  FocusNode titleFocus = FocusNode();
  FocusNode commentFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  int selectedRating = CommentData.rating;
  CommentPage({super.key , required this.job , required this.create});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: widget.create ? "New Comment" : "Edit Comment",
          leading: (){
            Navigator.of(context).pop();
        }
      ),
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          child: Form(
            key: widget._formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: getStars()
                  ),
                ),
                const MyDivider(margin: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20 , right: 20 , top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Title", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Title" ,
                          hintStyle: TextStyle(color: AppColor.hint,fontSize: 16),
                          border: UnderlineInputBorder()
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
                      const CustomText(text: "Comment", size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          decoration: const InputDecoration(hintText: "Comment" ,
                            hintStyle: TextStyle(color: AppColor.hint,fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                          ),
                          controller: widget.commentController,
                          focusNode: widget.commentFocus,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter comment";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: getButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getButton(){
    if(widget.create){
      return FirstPageButton(
        text: "Submit",
        color: AppColor.main,
        onTap:() async {
          if(widget.selectedRating == 0){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select rating") ,
                  duration: Duration(seconds: 2),)
            );
          }
          else if(widget._formKey.currentState!.validate()){
            try {
              if(widget.create) {
                await JobRequest.createComment(
                    widget.titleController.text,
                    widget.commentController.text,
                    widget.selectedRating,
                    widget.job.id!);
              }
              else{
                await JobRequest.editComment(
                    widget.titleController.text,
                    widget.commentController.text,
                    widget.selectedRating,
                    widget.job.id!,
                    CommentData.id
                );
              }

              Navigator.of(context).pop();
              Navigator.of(context).pop();
              CommentData.onSubmitTap!();
              CommentData.init();
            }
            catch(e){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()) ,
                    duration: const Duration(seconds: 2),)
              );
            }
          }
          else if(widget.titleController.text == ""){
            widget.titleFocus.requestFocus();
          }
          else if(widget.commentController.text == ""){
            widget.commentFocus.requestFocus();
          }
        }
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LongButton(
            text: "Change",
            onTap:() async {
              if(widget.selectedRating == 0){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select rating") ,
                      duration: Duration(seconds: 2),)
                );
              }
              else if(widget._formKey.currentState!.validate()){
                try {
                  if(widget.create) {
                    await JobRequest.createComment(
                        widget.titleController.text,
                        widget.commentController.text,
                        widget.selectedRating,
                        widget.job.id!);
                  }
                  else{
                    await JobRequest.editComment(
                        widget.titleController.text,
                        widget.commentController.text,
                        widget.selectedRating,
                        widget.job.id!,
                        CommentData.id
                    );
                  }

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  CommentData.onSubmitTap!();
                  CommentData.init();
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString()) ,
                        duration: const Duration(seconds: 2),)
                  );
                }
              }
              else if(widget.titleController.text == ""){
                widget.titleFocus.requestFocus();
              }
              else if(widget.commentController.text == ""){
                widget.commentFocus.requestFocus();
              }
            }
          ),
          const SizedBox(height: 10,),
          LongButton(
            text: "Delete",
            onTap:() async {
              try {
                await JobRequest.deleteComment(CommentData.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                CommentData.onSubmitTap!();
                CommentData.init();
              }
              catch(e){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()) ,
                      duration: const Duration(seconds: 2),));
              }
            }
          )
        ],
      );
    }
  }

  List<Widget> getStars() {
    List<Widget> children = [];
    for(int i = 1; i<=5 ; i++){
      if(widget.selectedRating == 0 ||
          i>widget.selectedRating){
        children.add(
          IconButton(
            onPressed: (){
              setState(() {
                widget.selectedRating = i;
              });
            },
            icon: const Icon(Icons.star_outline_rounded
              , size: 32,color: AppColor.loginText1,)
          )
        );
      }
      else{
        children.add(
            IconButton(
              onPressed: (){
                setState(() {
                  if(i == widget.selectedRating) {
                    widget.selectedRating = 0;
                  }
                  else{
                    widget.selectedRating = i;
                  }
                });
              },
              icon: const Icon(Icons.star_rounded
                , size: 32,color: AppColor.loginText1,)
            )
        );
      }
    }
    return children;
  }
}
