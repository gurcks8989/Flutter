import 'package:flutter/material.dart';

import '../app.dart';

enum loginCheckState {init, success, fail}

class LoginSection extends StatefulWidget {
  const LoginSection({Key? key,
    required this.cancelLoginFlow,
    required this.startSignUpFlow,
    required this.popAndPushNamed,
    required this.login,
  }) : super(key: key) ;
  final void Function() cancelLoginFlow ;
  final void Function() startSignUpFlow ;
  final void Function() popAndPushNamed ;
  final Future<int> Function(String email, String password) login;

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final TextEditingController _emailController = TextEditingController() ;
  final TextEditingController _passwordController = TextEditingController() ;
  final _formKey = GlobalKey<FormState>();
  int _loginFailed = 0 ;
  bool _passwordVisible  = true ;

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
              onPressed: () => widget.cancelLoginFlow(),
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(fontSize: 15),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    labelText: 'PASSWORD',
                    labelStyle: const TextStyle(fontSize: 15),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ?
                        Icons.visibility :
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    if (_loginFailed == loginCheckState.fail.index) {
                      return 'Wrong password. Try again.' ;
                    }
                    return null;
                  },
                  onTap: (){
                    _loginFailed = loginCheckState.init.index ;
                  },
                  onEditingComplete: (){
                    _loginFailed = loginCheckState.init.index ;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            shape : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minWidth: 500,
            color: Colors.pinkAccent,
            onPressed: () => {
              if (_formKey.currentState!.validate()) {
                widget.login(
                  _emailController.text,
                  _passwordController.text,
                ).then((isLogin){
                  setState(() {
                    _loginFailed = isLogin ;
                  });
                  if(_formKey.currentState!.validate() && isLogin == loginCheckState.success.index){
                    widget.popAndPushNamed() ;
                  }
                }),
              }
            },
            child: const Text(
              'LOGIN',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => widget.cancelLoginFlow(),
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
            onPressed: () => widget.startSignUpFlow(),
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