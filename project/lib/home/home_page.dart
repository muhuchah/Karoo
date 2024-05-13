import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/component/job_file.dart';
import 'package:project/request/job_request.dart';
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
                    getTopJobsWidget(context),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getCategories(categories!),
        ),
      );
    }
  }

  List<Widget> getCategories(List<Category> values){
    categories ??= values;
    List<Widget> children = [];
    List<Widget> rowChildren = [const SizedBox(width: 10,)];
    for(int i = 0 ; i< values.length; i++){
      rowChildren.add(Column(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(values[i].image!,
                  width: 80,height: 80,fit: BoxFit.fill,)),
              onTap: (){
                onTap(values[i].title!);
              },
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child:
                Text(values[i].title! , maxLines: 1,
                  overflow: TextOverflow.ellipsis,),
            )
          ),
        ],
      ));
      rowChildren.add(SizedBox(width: 10,));

      if((i+1)%4 == 0){
        children.add(
          SizedBox(width: width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget getTopJobsWidget(context){
    return FutureBuilder(
        future: JobRequest.getJobs(),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getTopJobs(context , snapShot.data!),
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

  List<Widget> getTopJobs(context ,List<Job> data){
    List<Widget> children = [];
    for(int i = 0 ; i<data.length ; i++){
      children.add(
        Column(children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return JobInfoPage(id : data[i].id! , userJob: false,);
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: JobListTile(job : data[i]),
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

// if(i == length){
//   if(values.length%4==0){
//     break;
//   }
//   children.add(
//     Expanded(
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         separatorBuilder: (context , index){
//           return const SizedBox(width: 10,);
//         },
//         itemCount: values.length%4,
//         itemBuilder: (context , index){
//           return Column(
//             children: [
//               SizedBox(
//                 width: 80,
//                 height: 80,
//                 child: GestureDetector(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(values[(i*4)+index].image!,
//                       width: 80,height: 80,fit: BoxFit.fill,)),
//                   onTap: (){
//                     onTap(values[i].title!);
//                   },
//                 ),
//               ),
//               Text(values[i].title!),
//             ],
//           );
//         }
//       ),
//     )
//   );
// }
// else{
//   children.add(
//     Expanded(
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         separatorBuilder: (context , index){
//           return const SizedBox(width: 10,);
//         },
//         itemCount: 4,
//         itemBuilder: (context , index){
//           return Column(
//             children: [
//               SizedBox(
//                 width: 80,
//                 height: 80,
//                 child: GestureDetector(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(values[(i*4)+index].image!,
//                       width: 80,height: 80,fit: BoxFit.fill,)),
//                   onTap: (){
//                     onTap(values[i].title!);
//                   },
//                 ),
//               ),
//               Text(values[i].title!),
//             ],
//           );
//         }
//       ),
//     )
//   );
// }
