import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../applicationState.dart';
import 'login_section.dart';
import 'register_section.dart';

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
    void _popAndPushNamed(){
      Navigator.popAndPushNamed(
        context,
        routeHome,
      ) ;
    }

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
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
                            popAndPushNamed: () => _popAndPushNamed(),
                            login: (email, password) => appState.signInWithEmailAndPassword(email, password),
                          )
                        ) :
                        appState.loginState == ApplicationLoginState.register ||
                        appState.loginState == ApplicationLoginState.email ?
                        Consumer<ApplicationState>(
                            builder: (context, appState, _) => RegisterSection(
                              cancelLoginFlow: () => appState.cancelLoginFlow(),
                              startLoginFlow: () => appState.startLoginFlow(),
                              verifyEmail : (email) => appState.verifyEmail(email),
                              registerAccount: (email, name, password) => appState.registerAccount(email, name, password, (e) { }),
                            )
                        ) :
                        MaterialButton(
                          padding: const EdgeInsets.all(20.0),
                          minWidth: 500,
                          child: const Text(
                            'Sign in with Email',
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
            onTap: () async {
              startSocialLoginFlow().then((_) {
                Navigator.popAndPushNamed(
                    context,
                    routeHome
                );
              }).catchError((e) => print(e));
            },
            child:
            viewState ?
            Container(
              padding: const EdgeInsets.all(0.0),
              width: 80.0,
              height: 50.0,
              child: Hero(
                tag: loginMethod,
                child: Image.asset(
                  logoPath,
                  cacheWidth: 30,
                ),
              ),
            ) :
            Container(
              padding: const EdgeInsets.all(0.0),
              height: 50.0, //MediaQuery.of(context).size.width * .08,
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
                        child: Hero(
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
      );
  }
}