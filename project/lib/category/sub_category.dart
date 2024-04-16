import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/category.dart';
import '../request/category_request.dart';
import '../utils/app_color.dart';
import '../widgets/my_appbars.dart';
import 'category_text_icon.dart';

class SubCategoryPage extends StatelessWidget {
  String mainCategory;
  Function(String value)? onTap;
  Function() leading;
  SubCategoryPage({super.key ,
    required this.mainCategory ,required this.leading , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: mainCategory,leading: leading,),
      backgroundColor: AppColor.background,
      body: FutureBuilder(
        future: CategoryRequest.subCategory(mainCategory),
        builder: (context,snapShot) {
          if(snapShot.hasData){
            return SizedBox(
              height: MediaQuery.of(context).size.height-100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getSubCategories(snapShot.data! , context),
                ),
              ),
            );
          }
          else if(snapShot.hasError){
            return SizedBox(
              height: 200,
              child: Center(child: Text(snapShot.error.toString() ,
                style: TextStyle(fontSize: 20),
              ),
              ),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  getSubCategories(List<Category> values, BuildContext context) {
    List<Widget> children = [];
    for(Category c in values){
      children.add(CategoryTextIcon(text: c.title!,
        onTap:(){
          onTap!(c.title!);
        })
      );
    }
    return children;
  }
}