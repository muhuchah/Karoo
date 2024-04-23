import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/category/sub_category.dart';
import 'package:project/home/bottom_navigation_bar.dart';

import '../component/category.dart';
import '../request/category_request.dart';
import '../utils/app_color.dart';
import '../widgets/my_appbars.dart';
import 'category_text_icon.dart';

class MainCategoriesPage extends StatelessWidget {
  Function(String value)? onTap;
  PreferredSizeWidget appBar;
  MainCategoriesPage({super.key , this.onTap , required this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColor.background,
      body: FutureBuilder(
        future: CategoryRequest.mainCategory(),
        builder: (context,snapShot) {
          if(snapShot.hasData){
            return SizedBox(
              height: MediaQuery.of(context).size.height-100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getCategories(snapShot.data! , context),
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

  List<Widget> getCategories(List<Category> categories , context){
    List<Widget> children = [];
    for(Category c in categories){
      children.add(CategoryTextIcon(
        text: c.title!,
        onTap: (){
          onTap!(c.title!);
        }),
      );
    }
    return children;
  }
}