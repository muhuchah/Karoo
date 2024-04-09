import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';

class MyBottomNavigation extends StatelessWidget{
  final void Function(MyNavigationBarMenus index) onTap;
  final int currentIndex;

  const MyBottomNavigation({super.key ,
    required this.onTap , required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(
        children: [
          Container(
            height: 1,
            color: AppColor.divider,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                IconButton(
                  onPressed: (){
                  onTap(MyNavigationBarMenus.home);
                  },
                  icon:Icon(Icons.house_outlined , size: 32,
                    color: currentIndex == 0 ? AppColor.button1 : Colors.black
                  )),
                Text("Home" ,
                  style: TextStyle(color: currentIndex == 0 ? AppColor.button1 : Colors.black),),
              ],),
              Column(children: [
                IconButton(
                  onPressed: (){
                    onTap(MyNavigationBarMenus.category);
                  },
                  icon:Icon(Icons.category_outlined , size: 32,
                      color: currentIndex == 1 ? AppColor.button1 : Colors.black
                  )),
                Text("Category" ,
                  style: TextStyle(color: currentIndex == 1 ? AppColor.button1 : Colors.black),),
              ],),
              Column(children: [
                IconButton(
                  onPressed: (){
                    onTap(MyNavigationBarMenus.job);
                  },
                  icon:Icon(Icons.work_outline , size: 32,
                      color: currentIndex == 2 ? AppColor.button1 : Colors.black
                  )),
                Text("Job" ,
                  style: TextStyle(color: currentIndex == 2 ? AppColor.button1 : Colors.black),),
              ],),
              Column(children: [
                IconButton(
                  onPressed: (){
                    onTap(MyNavigationBarMenus.person);
                  },
                  icon:Icon(Icons.person_outline , size: 32,
                      color: currentIndex == 3 ? AppColor.button1 : Colors.black
                  )),
                Text("Person" ,
                  style: TextStyle(color: currentIndex == 3 ? AppColor.button1 : Colors.black),),
              ],),
            ],
          )
        ],
      ),
    );
  }
}

enum MyNavigationBarMenus{
  home , category , job , person
}
