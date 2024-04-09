import 'package:flutter/material.dart';
import 'package:project/home/home_page_search.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.background,
        child: Column(
          children: [
            HomePageSearch(),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: getCategories(),
                ),
              ),
            )
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
}
