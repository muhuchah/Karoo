import 'package:flutter/material.dart';
import 'package:project/category/main_category.dart';
import 'package:project/category/sub_category.dart';
import 'package:project/home/bottom_navigation_bar.dart';
import 'package:project/job/display_job.dart';
import 'package:project/my_karoo/my_karoo_page.dart';

import 'home_page.dart';

class Home extends StatefulWidget {
  MainCategoriesPage? mainPage;
  String? selectedCategory;
  List<Widget> widgets = [
    HomePage(),
    Center(child: Text("Job Page"),),
    MyKarooPage(),
  ];
  int selectedIndex = 0;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child : widget.widgets[widget.selectedIndex]),
      bottomNavigationBar: MyBottomNavigation(
        currentIndex: widget.selectedIndex,
        onTap: (index){
          int current;
          if(index == MyNavigationBarMenus.home){
            current = 0;
          }
          else if(index == MyNavigationBarMenus.category){
            checkCategories();
            current = 1;
          }
          else if(index == MyNavigationBarMenus.job){
            current = 2;
          }
          else{
            current = 3;
          }

          setState(() {
            widget.selectedIndex= current;
          });
        },
      ),
    );
  }

  void checkCategories(){
    if(widget.widgets.length==3){
      widget.mainPage = MainCategoriesPage(
        onTap:(mainCategory){
          mainCategoryOnTap(mainCategory);
        },);
      setState(() {
        widget.widgets.insert(1,widget.mainPage!);
      });
    }
  }

  void mainCategoryOnTap(mainCategory){
    setState(() {
      widget.selectedCategory = mainCategory;
      widget.widgets[1] = SubCategoryPage(mainCategory: mainCategory,
        leading: subCategoryLeading , onTap: (subCategory){
          subCategoryOnTap(subCategory);
        },);
    });
  }

  void subCategoryLeading(){
    setState(() {
      widget.widgets[1] = widget.mainPage!;
    });
  }

  void subCategoryOnTap(subCategory){
    setState(() {
      widget.widgets[1] = DisplayJobPage(title: subCategory,
        subCategory: subCategory, leadingOnTap: (){
          jobLeading();
        }
      );
    });
  }

  void jobLeading(){
    setState(() {
      widget.widgets[1] = SubCategoryPage(mainCategory: widget.selectedCategory!,
        leading: subCategoryLeading , onTap: (subCategory){
          subCategoryOnTap(subCategory);
        },);
    });
  }
}
