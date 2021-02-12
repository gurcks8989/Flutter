import 'dart:ui';
import 'package:flutter/material.dart';

import 'SplashScreen.dart';
import 'LoginPage.dart';
import 'UserInterface.dart';

class CommonThings {
  static Size _size;
  String _address;

  CommonThings(){
    _size = null;
    _address = '/' ;
  }

  void setSize(Size size){
    _size = size ;
  }

  Size getSize(){
    return _size ;
  }

  void setAddress(String currentAddress){
    _address = currentAddress ;
  }

  String getAddress(){
    return _address ;
  }
}

void main() => runApp(MyApp());

CommonThings common = new CommonThings() ;

class MyApp extends StatelessWidget {
  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState != ConnectionState.done) {
            return SplashScreen();
          }
          else{
            common.setAddress("/login");
            print('set address') ;
            return address() ;
          }
        },
      ),
    );
  }
}

// ignore: camel_case_types
class address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    common.setSize(MediaQuery.of(context).size);
    print('Width of the screen: ${common.getSize().width}');
    print('current address ' + common.getAddress());
    return MaterialApp(
      initialRoute: common.getAddress(),
      routes: <String, WidgetBuilder>{
        "/": (context) => MyApp(),
        "/login": (context) => LoginPage(),
        "/main": (context) => MainPage(),
      },
    );
  }
}


void pushText(String s) {
  print('push ' + s);
}

final buttonSize = 30.0;

Widget mainMenu = Container(
  //padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
  child: Row(
    mainAxisSize: MainAxisSize.max, //가로로 꽉 채우기
    mainAxisAlignment: MainAxisAlignment.spaceBetween, //가로 방향으로 가운데 정렬하기
    crossAxisAlignment: CrossAxisAlignment.center, //세로 방향으로 가운데 정렬하기
    children: [
      FlatButton(
        child: Icon(
          Icons.home_filled,
          size: buttonSize,
        ),
        onPressed: () {
          //
        },
      ),
      FlatButton(
        child: Icon(
          Icons.search, //search /  image_search
          size: buttonSize,
        ),
        onPressed: () {
          //
        },
      ),
      FlatButton(
        child: Icon(
          Icons.add_box_outlined,
          size: buttonSize,
        ),
        onPressed: () {
          //
        },
      ),
      FlatButton(
        child: Icon(
          Icons.photo_rounded, //insert_photo_rounded //photo_rounded
          size: buttonSize,
        ),
        onPressed: () {
          //
        },
      ),
      FlatButton(
        child: Icon(
          Icons.person,
          size: buttonSize,
        ),
        onPressed: () {
          //
        },
      ),
    ],
  ),
);

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
    PlaceholderWidget(Colors.deepPurple),
  ];

  onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_rounded,
              color: Colors.black,
            ),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'User',
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
