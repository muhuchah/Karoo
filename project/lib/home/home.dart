import 'package:flutter/material.dart';
import 'package:project/category/main_category.dart';
import 'package:project/category/sub_category.dart';
import 'package:project/home/bottom_navigation_bar.dart';
import 'package:project/job/display_job.dart';
import 'package:project/my_karoo/my_karoo_page.dart';
import 'package:project/utils/app_color.dart';

import '../widgets/my_appbars.dart';
import 'home_page.dart';

class Home extends StatefulWidget {
  MainCategoriesPage? mainPage;
  DisplayJobPage? jobPage;
  HomePage? homePage;
  String? selectedCategory;
  List<Widget> widgets = [const MyKarooPage()];
  int selectedIndex = 0;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    checkHomePage();
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

  void checkHomePage() {
    if(widget.homePage == null){
      widget.homePage = HomePage(onTap: (mainCategory){
        mainCategoryOnTap(mainCategory , 0);
      });
      setState(() {
        widget.widgets.insert(0,widget.homePage!);
      });
    }
  }

  void checkCategories(){
    if(widget.mainPage == null){
      widget.mainPage = MainCategoriesPage(
        onTap:(mainCategory){
          mainCategoryOnTap(mainCategory , 1);
        },
        appBar: MainAppBar(text: "Category",),
      );
      setState(() {
        widget.widgets.insert(1,widget.mainPage!);
      });
    }
  }

  void checkJob(){
    if(widget.jobPage == null){
      widget.jobPage = DisplayJobPage(title: "My Jobs", subCategory: null ,
          leadingOnTap:null ,floatingActionButton: true , userJob: true,);
      setState(() {
        widget.widgets.insert(2,widget.jobPage!);
      });
    }
  }

  void mainCategoryOnTap(mainCategory , index){
    setState(() {
      widget.selectedCategory = mainCategory;
      widget.widgets[index] = SubCategoryPage(mainCategory: mainCategory,
        leading: (){
          subCategoryLeading(index);
        },
        onTap: (subCategory , id){
          subCategoryOnTap(subCategory , index, mainCategory);
        },
      );
    });
  }

  void subCategoryLeading(index){
    setState(() {
      if(index == 0){
        widget.widgets[index] = widget.homePage!;
      }
      else if(index==1){
        widget.widgets[index] = widget.mainPage!;
      }
    });
  }

  void subCategoryOnTap(subCategory , index, mainCategory){
    setState(() {
      widget.widgets[index] = DisplayJobPage(title: subCategory,
        floatingActionButton: false, userJob: false,
        subCategory: subCategory, leadingOnTap: (){
          jobLeading(index, mainCategory);
        },mainCategory: mainCategory,
      );
    });
  }

  void jobLeading(index, mainCategory){
    setState(() {
      widget.widgets[index] = SubCategoryPage(mainCategory: widget.selectedCategory!,
        leading:(){
          subCategoryLeading(index);
        } ,
        onTap: (subCategory , id){
          subCategoryOnTap(subCategory , index, mainCategory);
        },
      );
    });
  }
}
