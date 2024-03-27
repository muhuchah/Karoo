import 'package:flutter/material.dart';
import 'package:project/profile/profile_appbar.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/big_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfilePageAppBar()
    );
  }
}
