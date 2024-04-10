import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/home/home_list_tile.dart';
import 'package:project/home/home_page_search.dart';
import 'package:project/request/category_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

import '../component/category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                    FutureBuilder(
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
                    ),
                    Column(children: getTopJobs(),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getCategories(List<Category> categories){
    List<Widget> children = [];
    List<Widget> rowChildren = [];
    for(int i = 0 ; i<categories.length ; i++){
      rowChildren.add(Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(categories[i].image!,
              width: 80,height: 80,fit: BoxFit.fill,)),
          Text(categories[i].title!)
        ],
      ));

      if((i+1)%4 == 0){
        children.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:rowChildren,)
        );
        children.add(SizedBox(height: 30,));
        rowChildren = [];
      }
    }
    children.add(MyDivider());
    return children;
  }

  List<Widget> getTopJobs(){
    List<Widget> children = [];
    for(int i = 0 ; i<2 ; i++){
      children.add(
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: HomeListTile(),
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
