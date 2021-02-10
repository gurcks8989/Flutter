import 'dart:ui';
import 'package:flutter/material.dart';
import 'SignUpPage.dart';
import 'UserInterface.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initialization',
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.done) {
            return UserInterface(); //LoginPage();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

class Init {
  static Future initialize() async {
    await _registerServices();
    await _loadSettings();
  }

  static _registerServices() async {
    print("starting registering services");
    await Future.delayed(Duration(seconds: 3));
    print("finished registering services");
  }

  static _loadSettings() async {
    print("starting loading settings");
    await Future.delayed(Duration(seconds: 3));
    print("finished loading settings");
  }
}
//   Future.delayed(const Duration(milliseconds: 10000)).then((onValue) => true);

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  Widget imageSection = Container(
    padding: EdgeInsets.only(top: 150),
    child: Column(
      children: [
        Image.asset(
          'images/icon.jpeg',
          width: 100,
          height: 80,
          fit: BoxFit.scaleDown,
        ),
      ],
    ),
  );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'PicMap',
      softWrap: true,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontSize: 40,
        //fontFamily:
      ),
      textAlign: TextAlign.center,
    ),
  );

  Widget loadSection = Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            imageSection,
            textSection,
            loadSection,
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final _IDController = TextEditingController();
  final _PWController = TextEditingController();

  @override
  void dispose() {
    _IDController.dispose();
    _PWController.dispose();
  }

  Widget imageSection = Container(
    padding: EdgeInsets.only(top: 40),
    child: Column(
      children: [
        Image.asset(
          'images/icon.jpeg',
          width: 100,
          height: 80,
          fit: BoxFit.scaleDown,
        ),
      ],
    ),
  );

  Widget textSection = Container(
    //padding: const EdgeInsets.all(32),
    child: Text(
      'PicMap',
      softWrap: true,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontSize: 25,
        //fontFamily:
      ),
      textAlign: TextAlign.center,
    ),
  );
  //final _formKey = GlobalKey<FormState>();

  Widget textFieldSection = Container(
    width: 300,
    //child: Form(
    //key: _formKey,
    child: Table(
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(5),
      },
      //defaultColumnWidth: FixedColumnWidth(120.0),
      border: TableBorder.all(
          style: BorderStyle.none, color: Colors.black, width: 1),
      children: [
        TableRow(children: [
          Column(children: [Text('ID', style: TextStyle(fontSize: 20.0))]),
          Column(children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ID',
              ),
            ),
          ]),
        ]),
        TableRow(children: [
          Column(children: [Text('PW', style: TextStyle(fontSize: 20.0))]),
          Column(children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              //controller: _PWController,
            ),
          ]),
        ]),
      ],
    ),

    //),
  );

  //Log IN button
  Widget loginButtomSection = RaisedButton(
    padding: const EdgeInsets.only(
      left: 100,
      right: 100,
    ),
    child: Text('    Log IN    ', style: TextStyle(fontSize: 18)),
    onPressed: () {
      pushText('Login');
    },
    textColor: Colors.white,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            imageSection,
            textSection,
            textFieldSection,
            loginButtomSection,
            //logo
            SizedBox(height: 20),
            //sign up
            Container(
              alignment: Alignment(0.8, 0.0),
              child: RaisedButton(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  pushText('SignUp');
                  // 눌렀을 때 두 번째 route로 이동합니다.
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                textColor: Colors.black,
              ),
            ),

            //another login
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.only(
                      left: 100,
                      right: 100,
                    ),
                    child: Text('카카오로 로그인', style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      pushText('kakao');
                    },
                    textColor: Colors.black,
                    color: Colors.yellow,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.only(
                      left: 100,
                      right: 100,
                    ),
                    child: Text('네이버로 로그인', style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      pushText('naver');
                    },
                    textColor: Colors.white,
                    color: Colors.green,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.only(
                      left: 100,
                      right: 100,
                    ),
                    child: Text('  구글로 로그인 ', style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      pushText('naver');
                    },
                    textColor: Colors.black,
                    color: Colors.white,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
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

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home> {
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
            icon: Icon(Icons.home_filled, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, color: Colors.black,),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_rounded, color: Colors.black,),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black,),
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