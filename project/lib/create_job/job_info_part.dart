import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

import 'create_job_text_icon.dart';

class CreateJobInfoPage extends StatefulWidget {
  List<String> skills = [];
  CreateJobInfoPage({super.key});

  @override
  State<CreateJobInfoPage> createState() => _CreateJobInfoPageState();
}

class _CreateJobInfoPageState extends State<CreateJobInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Job Info",leading: (){
        Navigator.of(context).pop();
      },),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20 ,right: 20 , top: 10 , bottom: 20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.location_on_outlined , size: 24,),
                    text: "Location",
                    onTapString: "Choose",
                    onTap: (){
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.access_time_rounded , size: 24,),
                    text: "Time Table",
                    onTapString: "Set",
                    onTap: (){
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.diamond_outlined , size: 24,),
                    text: "Experience",
                    onTapString: "Set",
                    onTap: (){
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.wallet_outlined , size: 24,),
                    text: "Initial cost",
                    onTapString: "Set",
                    onTap: (){
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CreateJobTextIcon(
                    icon: const Icon(Icons.wallet_outlined , size: 24,),
                    text: "Approximate cost per hour",
                    onTapString: "Set",
                    onTap: (){
                    },
                  ),
                ),
                MyDivider(),
                Padding(
                  padding:const EdgeInsets.only(top: 25 , bottom: 10 , left: 20 , right: 20),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Skills", size: 20,
                              textColor: AppColor.loginText1, weight: FontWeight.bold),
                          IconButton(
                            onPressed: (){

                            },
                            icon: const Icon(Icons.add , size: 24 , color: AppColor.loginText1,)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: _getSkills(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getSkills(){
    List<Widget> children = [];
    for(int i=0;i<widget.skills.length;i++){
      children.add(
        CreateJobTextIcon(icon: null,
          assetPath: "asset/icons/arrow_drop_forward.png", text: widget.skills[i],
          onTapAssetPath: "asset/icons/multiply.svg", onTap: (){
            setState(() {
              widget.skills.removeAt(i);
            });
          }
        )
      );
    }
    return children;
  }
}
