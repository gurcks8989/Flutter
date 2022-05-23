import 'package:flutter/material.dart';
import 'map.dart';
import 'search.dart';
import 'add.dart';
import 'gallery.dart';
import 'userInterface.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Map(),
    Search(),
    Add(),
    Gallery(),
    UserInterface()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xFFFFA400),
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF373A36),
          selectedIconTheme: const IconThemeData(color: Color(0xFFFFA400)),
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          currentIndex: _currentIndex,
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_filled),
              icon: Icon(Icons.home_filled),
              label: 'Map',
              tooltip: 'Map',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.search),
              icon: Icon(Icons.search),
              label: 'Search',
              tooltip: 'Search',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.add_box_outlined),
              icon: Icon(Icons.add_box_outlined),
              label: 'Add',
              tooltip: 'Add',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.photo_rounded),
              icon: Icon(Icons.photo_rounded),
              label: 'Gallery',
              tooltip: 'Gallery',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings),
              label: 'Setting',
              tooltip: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
