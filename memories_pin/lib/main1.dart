import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp2(),
  ));
}

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Widget emptySection = Container(
      padding: const EdgeInsets.all(120),
      child: Text(
        '',
        softWrap: true,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 100,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/logo.jpg',
                      width: 295 / 5,
                      height: 250 / 5,
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'images/PicMap.jpg',
                      width: 362 / 5,
                      height: 122 / 5,
                    ),
                    SizedBox(height: 20),
/*
                  FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: "loading.png", placeholderScale: 5),

                  Image.asset(circularProgressIndicator, scale: 5),
*/
                    CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black54),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment(0.8, 0.0),
                child: FlatButton(
                  child: Text('login 화면으로 가는 임시 버튼',
                      style: TextStyle(fontSize: 15)),
                  onPressed: () {
                    // 눌렀을 때 두 번째 route로 이동합니다.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login_page()));
                  },
                  textColor: Colors.black,
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
