
import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
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
          MaterialButton(
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
          MaterialButton(
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