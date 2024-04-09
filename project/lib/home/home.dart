import 'package:flutter/material.dart';
import 'package:project/my_karoo/my_karoo_page.dart';

import 'home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgets = [
    HomePage(),
    Center(child: Text("Category Page"),),
    Center(child: Text("Job Page"),),
    MyKarooPage(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child : widgets[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: [],
      ),
    );
  }
}
