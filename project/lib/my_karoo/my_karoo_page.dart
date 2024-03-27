import 'package:flutter/material.dart';
import 'package:project/my_karoo/my_karoo_appbar.dart';
import 'package:project/my_karoo/my_karoo_list_tile.dart';

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
      appBar: MyKarooAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          MyKarooListTile(
            title: "Profile",
            icon: Icons.person_outline,
            onPressed:(){
              Navigator.of(context).pushReplacementNamed("/edit_profile");
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
        ],),
      ),
    );
  }
}