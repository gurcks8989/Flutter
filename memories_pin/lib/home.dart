import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'map.dart';
import 'search.dart';
import 'app.dart';
import 'add.dart';
import 'gallery.dart';
import 'userInterface.dart';
import 'main.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
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
