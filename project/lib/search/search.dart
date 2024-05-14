import 'package:flutter/material.dart';
import 'package:project/request/job_request.dart';
import 'package:project/search/search_field.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/divider.dart';

import '../component/job_file.dart';
import '../job/job_info.dart';
import '../widgets/custom_text.dart';
import '../widgets/job_list_tile.dart';

class SearchPage extends StatelessWidget {
  String search;
  SearchPage({super.key , required this.search});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          Container(
            height: 60,
            margin: const EdgeInsets.only(left: 20 , right: 20 , top: 40 , bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),color: Colors.white,),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_ios , size: 24,),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context){
                              return SearchFieldPage();
                            })
                        );
                      },
                      child: CustomText(text: search, size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.search_outlined , size: 24,)
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const MyDivider(),
          FutureBuilder(future: JobRequest.getSearchJobs(search),
            builder: (context , snapShot){
              if(snapShot.hasData){
                return getJobs(snapShot.data! , context);
              }
              else if(snapShot.hasError){
                return SizedBox(
                  height: 200,
                  child: Center(child: Text(snapShot.error.toString() ,
                    style: const TextStyle(fontSize: 20),),)
                  ,);
              }
              return const Center(child : CircularProgressIndicator());
            }
          )
        ],
      ),
    );
  }

  Widget getJobs(List<Job> data , context){
    return SizedBox(
      height: MediaQuery.of(context).size.height-150,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder:(context , index){
          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return JobInfoPage(id : data[index].id! , userJob: false,);
                    }),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20 , right: 20 , bottom: 20),
                  child: JobListTile(job : data[index]),
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: AppColor.divider,
              )
            ],
          );
        }
      ),
    );
  }
}
