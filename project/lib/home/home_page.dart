import 'package:flutter/material.dart';
import 'package:project/home/home_page_appbar.dart';
import 'package:project/utils/app_color.dart';

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
          ],
        ),
      ),
    );
  }
}
