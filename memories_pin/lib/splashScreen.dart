import 'package:flutter/material.dart';
import 'app.dart';
import 'main.dart';

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
  final Future _initFuture = Init.initialize();

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
        backgroundColor: Colors.white,
        color: Colors.black,
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

  Widget chargingSection = Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          value: 100,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    void showRelevant() async {
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, routeLogin); //  '/login'
    }

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              imageSection,
              textSection,
              FutureBuilder(
                future: _initFuture,
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.connectionState != ConnectionState.done) {
                    return loadSection;
                  }
                  else {
                    showRelevant();
                    return chargingSection;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
