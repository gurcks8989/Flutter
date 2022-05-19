import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class UserInterface extends StatelessWidget {
  final listFont = TextStyle(
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    Widget settingButton = Container(
      alignment: Alignment(1, 0.0),
      child: IconButton(
        icon: Icon(Icons.settings),
        color: Colors.black38,
        iconSize: 40.0,
        onPressed: () {
          print('push Setting');
        },
      ),
    );

    Widget buttonSection = Container(
      height: 100,
      color: Colors.black12,
      child: Row(
        mainAxisSize: MainAxisSize.max, //가로로 꽉 채우기
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //가로 방향으로 가운데 정렬하기
        crossAxisAlignment: CrossAxisAlignment.center, //세로 방향으로 가운데 정렬하기
        children: [
          FlatButton(
            minWidth: 200 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '23',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ), //number of posting
                Text(
                  '내 게시물 수',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            onPressed: () {
              print('push MyPosting');
            },
          ),
          Container(width: 1, height: 80, color: Colors.black),
          //),
          FlatButton(
            minWidth: 200 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/tem_118pixel.png',
                  width: 50,
                ),
                Text(
                  '내 믿음 온도',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            onPressed: () {
              print('push manner_tamp');
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text('믿음 온도란..?'),
                      content: Image.asset('images/manner_tamp.jpeg'),
                      /*actions: [
                        IconButton(
                          icon : Icon(Icons.clear),
                          onPressed: () {
                          })
                      ],*/
                    );
                  });
            },
          ),
          Container(width: 1, height: 80, color: Colors.black),
          FlatButton(
            minWidth: 200 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '8',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ), //number of recommend
                Text(
                  '추천 수',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            onPressed: () {
              print('push recommend');
            },
          ),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            settingButton,
            Image.asset(
              'images/profile_img_343pixel.jpeg',
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Text(
              '권혁찬',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 4.0,
              ),
            ),
            Text(
              '21700057@handong.edu',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            buttonSection,
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            ListTile(
              title: Text(
                '내 게시물 관리',
                style: listFont,
              ),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                //Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) => nextPage()),
                //           );
              },
            ),
            ListTile(
              title: Text(
                '회원 정보 수정',
                style: listFont,
              ),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => modifiedUser()),
                );
              },
            ),
            ListTile(
              title: Text(
                '공지사항',
                style: listFont,
              ),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                //Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) => nextPage()),
                //           );
              },
            ),
            ListTile(
              title: Text(
                '문의하기',
                style: listFont,
              ),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                //Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) => nextPage()),
                //           );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class modifiedUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              IconButton(
                //alignment: Alignment(-45.0, 5.0),
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Image.asset(
            'images/profile_img_409pixel.jpeg',
            height: 140,
          ),
          FlatButton(
            child: Text(
              '사진 수정',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              //TODO
            },
          ),
          Container(
            width: 300,
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(4),
              },
              //defaultColumnWidth: FixedColumnWidth(120.0),
              border: TableBorder.all(style: BorderStyle.none),
              children: [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 200 / 40),
                    child: Text(
                      '이메일',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        bottom: 200 / 40,
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 200 / 40),
                    child: Text(
                      '닉네임',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        bottom: 200 / 40,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          RaisedButton(
            padding: const EdgeInsets.only(
              left: 100,
              right: 100,
            ),
            child: Text(' 회원정보 수정 ', style: TextStyle(fontSize: 18)),
            onPressed: () {
              print('push modified');
              //todo
            },
            textColor: Colors.white,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
