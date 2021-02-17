import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';

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
          width: common.getWidth()/4,
          //height: 80,
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
    width: common.getWidth() * 0.7,
    height: common.getHeight() / 5,
    //child: Form(
    //key: _formKey,,
    child: Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(8),
            2: FlexColumnWidth(0.5),
          },
          //defaultColumnWidth: FixedColumnWidth(120.0),
          border: TableBorder.all(style: BorderStyle.none),
          children: [
            TableRow(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: common.getHeight() / 50),
                  child: Text(
                    'ID',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: common.getWidth() / 2,
                          vertical: common.getHeight() / 60),
                      border: OutlineInputBorder(),
                      //hintText: 'ID',
                    ),
                  ),
                ),
                Container(),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: common.getHeight() / 150),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: common.getHeight() / 150),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: common.getHeight() / 150),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: common.getHeight() / 50),
                  child: Text('PW',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0)),
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    obscureText: true, // 문자 입력시 '*'로 보임,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: common.getWidth() / 2,
                          vertical: common.getHeight() / 60),
                      border: OutlineInputBorder(),
                      //hintText: 'Password',
                    ),
                    //controller: _PWController,
                  ),
                ),
                Container(),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget blueLine = Expanded(
      child: Container(
    color: Colors.indigoAccent,
    height: 1,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              imageSection,
              textSection,
              SizedBox(height: common.getHeight() / 30),
              textFieldSection,
              //sign up
              Container(
                width: common.getWidth() * 0.7,
                child: Row(
                  children: [
                    blueLine,
                    FlatButton(
                      child: Text(
                        'forgive Password?',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        print('push Forgive button');
                        common.setAddress("/signUp");
                        // 눌렀을 때 두 번째 route로 이동합니다.
                        Navigator.pushNamed(context, "/signUp");
                      },
                      textColor: Colors.indigoAccent,
                    ),
                    blueLine,
                    FlatButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        print('push SignUp button');
                        common.setAddress("/signUp");
                        Navigator.pushNamed(context, "/signUp");
                      },
                      textColor: Colors.indigoAccent,
                    ),
                    blueLine,
                  ],
                ),
              ),

              SizedBox(height: common.getHeight() / 150),

              RaisedButton(
                padding: const EdgeInsets.only(
                  left: 100,
                  right: 100,
                ),
                child: Text('    Log IN    ', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  print('push Login button');
                  common.setAddress("/main");
                  Navigator.pushNamed(context, "/main");
                },
                textColor: Colors.white,
                color: Colors.black,
              ),


              SizedBox(height: common.getHeight() / 30),

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
                        print('push kakao button');
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
                        print('push naver button');
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
                        print('push google button');
                      },
                      textColor: Colors.black,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
