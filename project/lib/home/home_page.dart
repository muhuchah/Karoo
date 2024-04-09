import 'package:flutter/material.dart';
import 'package:project/my_karoo/my_karoo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: "Category"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Home"
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
