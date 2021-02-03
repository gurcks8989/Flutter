import 'dart:ui';
import 'package:flutter/material.dart';
import 'SignUpPage.dart';

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
            return LoginPage(); //LoginPage();
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
    width: 400,
    child: Form(
      //key: _formKey,
      child: Container(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ID',
              ),
              //controller: _IDController,
            ),
            Padding(padding: const EdgeInsets.only(bottom:10),),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              //controller: _PWController,
            ),
          ],
        ),
      ),
    ),
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

  static pushText(String s) {
    print('push ' + s);
  }
}
