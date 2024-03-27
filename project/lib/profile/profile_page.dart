import 'package:flutter/material.dart';
import 'package:project/profile/profile_appbar.dart';
import 'package:project/profile/profile_list_text.dart';
import 'package:project/profile/profile_list_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfilePageAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          ProfileListTile(
            title: "Profile",
            icon: Icons.person_outline,
            onPressed:(){
              Navigator.of(context).pushReplacementNamed("/edit_profile");
            },
          ),
          ProfileListTile(
            title: "Orders",
            icon: Icons.ad_units_outlined,
            onPressed:(){

            },
          ),
          ProfileListTile(
            title: "Bookmarks",
            icon: Icons.bookmark_border,
            onPressed:(){

            },
          ),
          ProfileListTile(
            title: "Chats",
            icon: Icons.chat,
            onPressed:(){

            },
          ),
          SizedBox(height: 40,),
          ProfileListText(text: "Help"),
          ProfileListText(text: "Support"),
          ProfileListText(text: "Karoo FAQ"),
          ProfileListText(text: "About Karoo"),
          ProfileListText(text: "Contact us"),
        ],),
      ),
    );
  }
}
