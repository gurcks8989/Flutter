import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../applicationState.dart';
import '../main.dart';

class Setting extends StatelessWidget {

  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _popAndPushNamed(){
      Navigator.popAndPushNamed(
        context,
        routeHome,
      ) ;
    }

    Widget buttonSection = Container(
      height: 100,
      color: Colors.black12,
      child: Row(
        mainAxisSize: MainAxisSize.max, //가로로 꽉 채우기
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //가로 방향으로 가운데 정렬하기
        crossAxisAlignment: CrossAxisAlignment.center, //세로 방향으로 가운데 정렬하기
        children: [
          MaterialButton(
            minWidth: 200 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
          MaterialButton(
            minWidth: 200 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.brightness_7_outlined,
                  size: 50,
                  color: Color(0xFFF1F1F1),
                ),
                const Text(
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
                      title: const Text('믿음 온도란..?'),
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
          MaterialButton(
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
            Consumer<ApplicationState>(
              builder: (context, appState, _) => Column(
                children: [
                  appState.userElement.path == '' ?
                  Icon(Icons.person) :
                  Image.asset(
                    appState.userElement.path,
                    height: 120,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Text(
                    appState.userElement.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    appState.userElement.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),


            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            buttonSection,
            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => SettingList(
                  listTitle: '내 게시물 관리',
                  popAndPushNamed: _popAndPushNamed
              ),
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => SettingList(
                  listTitle: '회원 정보 수정',
                  popAndPushNamed: _popAndPushNamed
              ),
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => SettingList(
                  listTitle: '공지사항',
                  popAndPushNamed: _popAndPushNamed
              ),
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => SettingList(
                  listTitle: '문의하기',
                  popAndPushNamed: _popAndPushNamed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  const SettingList({required this.listTitle, required this.popAndPushNamed}) ;

  final String listTitle ;
  final void Function() popAndPushNamed ;

  final listFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return
      ListTile(
        title: Text(
          listTitle,
          style: listFont,
        ),
        trailing: const Icon(Icons.navigate_next),
        onTap: () => popAndPushNamed(),
      );
  }
}
