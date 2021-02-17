import 'package:flutter/material.dart';
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
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.orange),
    UserInterface(),
  ];

  onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.amber[800],
        iconSize: 40,
        onTap: onTapped, // new
        currentIndex: _currentIndex, // new
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.black,
            ),
            title: Text('', style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            title: Text('', style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
            title: Text('', style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_rounded,
              color: Colors.black,
            ),
            title: Text('', style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text('', style: TextStyle(fontSize: 0)),
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
