import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Map.dart';
import 'Search.dart';
import 'Add.dart';
import 'Gallery.dart';
import 'UserInterface.dart';
import 'main.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        iconSize: common.getWidth() / 10,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex, // new
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search),
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_box_outlined),
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.photo_rounded),
            icon: Icon(Icons.photo_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
