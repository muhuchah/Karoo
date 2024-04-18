import 'package:flutter/material.dart';
import 'package:project/category/main_category.dart';
import 'package:project/category/sub_category.dart';
import 'package:project/home/bottom_navigation_bar.dart';
import 'package:project/job/display_job.dart';
import 'package:project/my_karoo/my_karoo_page.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

import 'home_page.dart';

class Home extends StatefulWidget {
  MainCategoriesPage? mainPage;
  DisplayJobPage? jobPage;
  String? selectedCategory;
  List<Widget> widgets = [
    HomePage(),
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
    checkCategories();
    checkJob();
    return Scaffold(
      backgroundColor: AppColor.background,
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
    if(widget.mainPage == null){
      widget.mainPage = MainCategoriesPage(
        onTap:(mainCategory){
          mainCategoryOnTap(mainCategory);
        },);
      setState(() {
        widget.widgets.insert(1,widget.mainPage!);
      });
    }
  }

  void checkJob(){
    if(widget.jobPage == null){
      widget.jobPage = DisplayJobPage(title: "My Jobs", subCategory: null ,
          leadingOnTap:null , floatingActionButton: GestureDetector(
          onTap: (){

          },
          child: Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColor.main,
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0 , right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "New Job", size: 20,
                      textColor: AppColor.background, weight: FontWeight.bold),
                  Icon(Icons.add , size: 32,color: AppColor.background,)
                ],
              ),
            ),
          ),),);
      setState(() {
        widget.widgets.insert(2,widget.jobPage!);
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
