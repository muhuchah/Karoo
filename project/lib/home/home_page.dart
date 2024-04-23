import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/widgets/job_list_tile.dart';
import 'package:project/home/home_page_search.dart';
import 'package:project/request/category_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

import '../component/category.dart';
import '../job/job_info.dart';

class HomePage extends StatelessWidget {
  List<Category>? categories = null;
  double? width;
  final Function(String mainCategory) onTap;
  HomePage({super.key , required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: AppColor.background,
        child: Column(
          children: [
            HomePageSearch(),
            SizedBox(height: 10,),
            Container(
              height: height-210,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getCategoryWidgets(),
                    Column(children: getTopJobs(context),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryWidgets(){
    if(categories == null){
      return FutureBuilder(
        future: CategoryRequest.mainCategory(),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return Container(
              margin: EdgeInsets.only(top: 10 , right: 10 , left: 10),
              child: Column(
                children: getCategories(snapShot.data!),
              ),
            );
          }
          else if(snapShot.hasError){
            return Container(
              height: 200,
              child: Center(child: Text(snapShot.error.toString() ,
                style: TextStyle(fontSize: 20),),)
              ,);
          }
          return Center(child : CircularProgressIndicator());
        }
      );
    }
    else{
      return Container(
        margin: EdgeInsets.only(top: 10 , right: 10 , left: 10),
        child: Column(
          children: getCategories(categories!),
        ),
      );
    }
  }

  List<Widget> getCategories(List<Category> values){
    categories ??= values;
    List<Widget> children = [];
    List<Widget> rowChildren = [SizedBox(width: 10,)];
    for(int i = 0 ; i<values.length ; i++){
      rowChildren.add(Column(
        children: [
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(values[i].image!,
                width: 80,height: 80,fit: BoxFit.fill,)),
            onTap: (){
              onTap(values[i].title!);
            },
          ),
          Text(values[i].title!)
        ],
      ));
      rowChildren.add(SizedBox(width: 10,));

      if((i+1)%4 == 0){
        children.add(
          SizedBox(width: width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:rowChildren,),
            ),
          )
        );
        children.add(SizedBox(height: 30,));
        rowChildren = [SizedBox(width: 10,)];
      }
    }
    children.add(MyDivider());
    return children;
  }

  List<Widget> getTopJobs(context){
    List<Widget> children = [];
    for(int i = 0 ; i<2 ; i++){
      children.add(
        Column(children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return JobInfoPage();
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: JobListTile(),
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: AppColor.divider,)
          ],
        ),
      );
    }
    return children;
  }
}
