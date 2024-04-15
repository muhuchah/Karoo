import 'package:flutter/material.dart';
import 'package:project/category/sub_category.dart';

import '../component/category.dart';
import '../request/category_request.dart';
import '../utils/app_color.dart';
import '../widgets/main_appbar.dart';
import 'category_text_icon.dart';

class MainCategoriesPage extends StatelessWidget {
  MainCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(text: "Category",),
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
      children.add(CategoryTextIcon(text: c.title!, onTap:() {
        Navigator.of(context).push(MaterialPageRoute(
            builder:(context) => SubCategoryPage(mainCategory: c.title!)
        ));
      }));
    }
    return children;
  }
}