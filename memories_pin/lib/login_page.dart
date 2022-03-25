import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:loading_gifs/loading_gifs.dart';
import 'SignUpPage.dart';

// ignore: camel_case_types
class login_page extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Widget emptySection = Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        '',
        softWrap: true,
      ),
    );
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              //logo
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Image.asset(
                      'images/icon.jpeg',
                      width: 100,
                      height: 80,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 10),
                    Text(
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
                    SizedBox(height: 20),
                  ],
                ),
              ),

              //login
              Container(),

              //sign up
              Container(
                alignment: Alignment(0.8, 0.0),
                child: FlatButton(
                  child: Text('Sign Up', style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    // 눌렀을 때 두 번째 route로 이동합니다.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  textColor: Colors.black,
                ),
              ),

              //Log IN button
              Container(
                child: RaisedButton(
                  child: Text('                    Log IN                    ',
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
              ),

              //another login
              Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                          '                  카카오로 로그인                  ',
                          style: TextStyle(fontSize: 15)),
                      onPressed: showMessage,
                      textColor: Colors.black,
                      color: Colors.yellow,
                    ),
                    RaisedButton(
                      child: Text(
                          '                   네이버로 로그인                 ',
                          style: TextStyle(fontSize: 15)),
                      onPressed: showMessage,
                      textColor: Colors.white,
                      color: Colors.green,
                    ),
                    RaisedButton(
                      child: Text(
                          '                    구글로 로그인                    ',
                          style: TextStyle(fontSize: 15)),
                      onPressed: showMessage,
                      textColor: Colors.black,
                      color: Colors.white,
                    ),
                    SizedBox(height: 50),
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
