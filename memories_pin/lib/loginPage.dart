import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SignUpPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/icon.png',
                    width: 100,
                    height: 80,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Memories Pin',
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 40,
                      //fontFamily:
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Container(),
              Container(
                alignment: Alignment(0.8, 0.0),
                child: FlatButton(
                  child: const Text('Sign Up', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    // 눌렀을 때 두 번째 route로 이동합니다.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  textColor: Colors.black,
                ),
              ),
              RaisedButton(
                child: const Text('                    Log IN                    ',
                    style: TextStyle(fontSize: 18)),
                onPressed: showMessage,

                /*
                  onPressed: () {
                  print('눌림!');

              },
                 */
                textColor: Colors.white,
                color: Colors.black,
              ),

              //another login
              Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: const Text(
                          '                  카카오로 로그인                  ',
                          style: TextStyle(fontSize: 15)),
                      onPressed: showMessage,
                      textColor: Colors.black,
                      color: Colors.yellow,
                    ),
                    RaisedButton(
                      child: const Text(
                          '                   네이버로 로그인                 ',
                          style: TextStyle(fontSize: 15)),
                      onPressed: showMessage,
                      textColor: Colors.white,
                      color: Colors.green,
                    ),
                    RaisedButton(
                      child: const Text(
                          '                    구글로 로그인                    ',
                          style: TextStyle(fontSize: 15)),
                      onPressed: showMessage,
                      textColor: Colors.black,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ])),
      ),
    );
  }

  void showMessage() {
    print("clicked!");
  }
}
