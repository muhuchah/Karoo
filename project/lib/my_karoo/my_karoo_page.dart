import 'package:flutter/material.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';
import 'package:project/my_karoo/my_karoo_list_tile.dart';
import 'package:project/utils/app_color.dart';

import 'my_karoo_list_text.dart';

class MyKarooPage extends StatefulWidget {
  const MyKarooPage({super.key});

  @override
  State<MyKarooPage> createState() => _MyKarooPageState();
}

class _MyKarooPageState extends State<MyKarooPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: MainAppBar(text: "Karoo",actions: [
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.add_alert_rounded),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.settings),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        const SizedBox(width: 10,)
      ],),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyKarooListTile(
                title: "Profile",
                icon: Icons.person_outline,
                onPressed:(){
                  Navigator.of(context).pushNamed("/profile");
                },
              ),
              MyKarooListTile(
                title: "Orders",
                icon: Icons.ad_units_outlined,
                onPressed:(){

                },
              ),
              MyKarooListTile(
                title: "Bookmarks",
                icon: Icons.bookmark_border,
                onPressed:(){

                },
              ),
              MyKarooListTile(
                title: "Chats",
                icon: Icons.chat,
                onPressed:(){

                },
              ),
              SizedBox(height: 40,),
              MyKarooListText(text: "Help"),
              MyKarooListText(text: "Support"),
              MyKarooListText(text: "Karoo FAQ"),
              MyKarooListText(text: "About Karoo"),
              MyKarooListText(text: "Contact us"),
              const SizedBox(height: 50,),
              const Padding(
                padding: EdgeInsets.only(left: 20 , bottom: 20),
                child: CustomText(text: "Karoo v1.0.0", size: 16,
                    textColor: AppColor.hint, weight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
