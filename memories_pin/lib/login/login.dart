import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../applicationState.dart';
import 'registerSection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    ApplicationState().signOut() ;
    super.initState();
  }
  get borderRadius => BorderRadius.circular(12.0);

  Widget orSection = Stack(
    children: [
      const Divider(
        height: 25,
        thickness: 1,
        color: Colors.black,
      ),
      Center(
        child: Container(
          alignment: Alignment.center,
          width: 30,
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
          ),
          child: const Text('OR'),
        ),
      ),
    ],
  ) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo/black_drawing.png',
                    fit: BoxFit.scaleDown,
                  ),
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
                  Consumer<ApplicationState>(
                    builder: (context, appState, _) => Material(
                      elevation: 20,
                      borderRadius: borderRadius,
                      child:
                      appState.loginState == ApplicationLoginState.login ?
                      Consumer<ApplicationState>(
                        builder: (context, appState, _) => LoginSection(
                          cancelLoginFlow: () => appState.cancelLoginFlow(),
                          startSignUpFlow: () => appState.startSignUpFlow(),
                        )
                      ) :
                      appState.loginState == ApplicationLoginState.signUp ?
                      Consumer<ApplicationState>(
                          builder: (context, appState, _) => RegisterSection(
                            cancelLoginFlow: () => appState.cancelLoginFlow(),
                            startLoginFlow: () => appState.startLoginFlow(),
                          )
                      ) :
                      MaterialButton(
                        padding: const EdgeInsets.all(20.0),
                        minWidth: 500,
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () => appState.startLoginFlow(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  orSection,
                  const SizedBox(height: 10),
                  Consumer<ApplicationState>(
                  builder: (context, appState, _) =>
                    appState.loginState != ApplicationLoginState.loggedOut ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<ApplicationState>(
                          builder: (context, appState, _) => SocialLogin(
                            loginMethod: 'GOOGLE',
                            logoPath: 'assets/logo/google.png',
                            iconColor: Colors.white,
                            textColor: Colors.black54,
                            viewState: appState.loginState != ApplicationLoginState.loggedOut,
                            startSocialLoginFlow: () => appState.startGoogleLoginFlow(),
                          ),
                        ),
                        Consumer<ApplicationState>(
                          builder: (context, appState, _) => SocialLogin(
                            loginMethod: 'NAVER',
                            logoPath: 'assets/logo/naver.png',
                            iconColor: const Color(0xFF1EC701),
                            textColor: Colors.white,
                            viewState: appState.loginState != ApplicationLoginState.loggedOut,
                            startSocialLoginFlow: () => appState.startGoogleLoginFlow(),
                          ),
                        ),
                        Consumer<ApplicationState>(
                          builder: (context, appState, _) => SocialLogin(
                            loginMethod: 'KAKAO',
                            logoPath: 'assets/logo/kakao.png',
                            iconColor: const Color(0xFFFDDB03),
                            textColor: Colors.black54,
                            viewState: appState.loginState != ApplicationLoginState.loggedOut,
                            startSocialLoginFlow: () => appState.startGoogleLoginFlow(),
                          ),
                        ),
                      ],
                    ) :
                    SizedBox(
                      height: 50 * 3 + 10 * 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<ApplicationState>(
                            builder: (context, appState, _) => SocialLogin(
                              loginMethod: 'GOOGLE',
                              logoPath: 'assets/logo/google.png',
                              iconColor: Colors.white,
                              textColor: Colors.black54,
                              viewState: appState.loginState != ApplicationLoginState.loggedOut,
                              startSocialLoginFlow: () => appState.startGoogleLoginFlow(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Consumer<ApplicationState>(
                            builder: (context, appState, _) => SocialLogin(
                              loginMethod: 'NAVER',
                              logoPath: 'assets/logo/naver.png',
                              iconColor: const Color(0xFF1EC701),
                              textColor: Colors.white,
                              viewState: appState.loginState != ApplicationLoginState.loggedOut,
                              startSocialLoginFlow: () => appState.startGoogleLoginFlow(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Consumer<ApplicationState>(
                            builder: (context, appState, _) => SocialLogin(
                              loginMethod: 'KAKAO',
                              logoPath: 'assets/logo/kakao.png',
                              iconColor: const Color(0xFFFDDB03),
                              textColor: Colors.black54,
                              viewState: appState.loginState != ApplicationLoginState.loggedOut,
                              startSocialLoginFlow: () => appState.startGoogleLoginFlow(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    required this.loginMethod,
    required this.logoPath,
    required this.iconColor,
    required this.textColor,
    required this.viewState,
    required this.startSocialLoginFlow,
  });

  final String loginMethod ;
  final String logoPath ;
  final Color iconColor ;
  final Color textColor ;
  final bool viewState ;
  final Future<void> Function() startSocialLoginFlow;

  get borderRadius => BorderRadius.circular(12.0);

  @override
  Widget build(BuildContext context) {
    return
      Material(
        elevation: 5,
        borderRadius: borderRadius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: iconColor,
          ),
          child: InkWell(
            onTap: () async{
              startSocialLoginFlow().then((_){
                Navigator.popAndPushNamed(
                    context,
                    routeHome
                ) ;
              }).catchError((e) => print(e));
            },
            child:
            viewState ?
            Container(
              padding: const EdgeInsets.all(0.0),
              width: 80.0,
              height: 50.0,
              child : Hero(
                tag: loginMethod,
                child: Image.asset(
                  logoPath,
                  cacheWidth: 30,
                ),
              ),
            ) :
            Container(
              padding: const EdgeInsets.all(0.0),
              height: 50.0,//MediaQuery.of(context).size.width * .08,
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraints) {
                    return
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxHeight,
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: borderRadius,
                        ),
                        child : Hero(
                          tag: loginMethod,
                          child: Image.asset(
                            logoPath,
                            cacheWidth: 30,
                          ),
                        ),
                      );
                  }),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Sign in with ' + loginMethod,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ) ;
  }
}

class LoginSection extends StatelessWidget {
  LoginSection({Key? key,
    required this.cancelLoginFlow,
    required this.startSignUpFlow,
  }) : super(key: key) ;
  final TextEditingController _loginIdController = TextEditingController() ;
  final TextEditingController _passwordController = TextEditingController() ;
  final void Function() cancelLoginFlow ;
  final void Function() startSignUpFlow ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'LOGIN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: () => cancelLoginFlow(),
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _loginIdController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              labelText: 'ID',
              labelStyle: TextStyle(fontSize: 15),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Colors.redAccent),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              labelText: 'PASSWORD',
              labelStyle: TextStyle(fontSize: 15),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Colors.redAccent),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            shape : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minWidth: 500,
            color: Colors.pinkAccent,
            onPressed: () => cancelLoginFlow(),
            child: const Text(
              'LOGIN',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => cancelLoginFlow(),
              child: const Text(
                'Forget Password?',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () => startSignUpFlow(),
            child: const Text.rich(
              TextSpan(
                text: 'Need an account? ',
                style: TextStyle(color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                      text: 'SIGN UP',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                      )),
                  // can add more TextSpans here...
                ],
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}