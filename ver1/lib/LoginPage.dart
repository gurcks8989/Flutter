import 'package:flutter/material.dart';
import 'SignUpPage.dart';
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
    //key: _formKey,,
    child: Table(
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(5),
      },
      //defaultColumnWidth: FixedColumnWidth(120.0),
      border: TableBorder.all(
        style: BorderStyle.none,
      ),
      // color: Colors.black, width: 1),
      children: [
        TableRow(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: common.getSize().height / 40),
              child: Text(
                'ID',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'ID',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Column(
              children: [
                SizedBox(height: common.getSize().height / 40),
                Text('PW', style: TextStyle(fontSize: 20.0)),
              ],
            ),
            TextFormField(
              obscureText: true, // 문자 입력시 '*'로 보임,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //hintText: 'Password',
              ),
              //controller: _PWController,
            ),
          ],
        ),
      ],
    ),
  );

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
              textFieldSection,
              RaisedButton(
                padding: const EdgeInsets.only(
                  left: 100,
                  right: 100,
                ),
                child: Text('    Log IN    ', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  print('push Login button');
                  Navigator.pushNamed(context, "/main");
                },
                textColor: Colors.white,
                color: Colors.black,
              ),
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
                    print('push SignUp button');
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
                    SizedBox(height: 50),
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
