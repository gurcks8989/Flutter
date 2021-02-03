import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

// ignore: camel_case_types
class _signUpPageState extends State<SignUpPage> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "PicMap",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            SizedBox(height: 80),
            Column(
              children: [
                Image.asset(
                  'images/icon.jpeg',
                  width: 120,
                  height: 120,
                ),
                Text('PicMap',
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 40,
                      //fontFamily:
                    ),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 50,
                ),
                SignUpForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter ID';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "ID",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter User Name';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "User Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30),
              color: Color(0xff01A0C7),
              //padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'SIGN UP',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
