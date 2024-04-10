import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/home/home_list_tile.dart';
import 'package:project/home/home_page_search.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);
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
                    Container(
                      margin: EdgeInsets.only(top: 10 , right: 10 , left: 10),
                      child: Column(
                        children: getCategories(),
                      ),
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

  List<Widget> getCategories(){
    List<Widget> children = [];
    List<Widget> rowChildren = [];
    for(int i = 1 ; i<=8 ; i++){
      rowChildren.add(Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Image.asset("asset/car.jpg"),),
          Text("Coloring")
        ],
      ));

      if(i%4 == 0){
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
