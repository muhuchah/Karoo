import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import '../first/first_page_button.dart';
import '../widgets/custom_text.dart';

class CommentPage extends StatefulWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  int selectedRating = 0;
  CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "New Comment", leading: (){
        Navigator.of(context).pop();
      }),
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
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          decoration: const InputDecoration(hintText: "Comment" ,
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    child: FirstPageButton(
                      text: "Submit",
                      color: AppColor.main,
                      onTap:(){

                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
