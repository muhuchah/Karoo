import 'package:flutter/material.dart';
import 'package:project/profile/profile_appbar.dart';
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
      body: Column(children: [
        ProfileListTile(title: "Profile",icon: Icons.person_outline,),
        ProfileListTile(title: "Orders",icon: Icons.ad_units_outlined,),
        ProfileListTile(title: "Bookmarks",icon: Icons.bookmark_border,),
        ProfileListTile(title: "Chats",icon: Icons.chat,),
      ],),
    );
  }
}
