import 'dart:async';

import 'package:flutter/material.dart' ;

class RegisterSection extends StatefulWidget {
  RegisterSection({
    required this.cancelLoginFlow,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.registerAccount,
  }) ;

  final void Function() cancelLoginFlow ;
  final void Function() startLoginFlow ;
  final Future<bool> Function(String email) verifyEmail;
  final Future<void> Function(String email, String name, String password) registerAccount;

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final TextEditingController _emailController = TextEditingController() ;
  final TextEditingController _nameController = TextEditingController() ;
  final TextEditingController _passwordController = TextEditingController() ;
  final _formKey = GlobalKey<FormState>();
  bool _alreadyExistEmail = false ;
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
              'SIGN UP',
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
                    if(value!.isEmpty) {
                      return 'Enter your email address';
                    }
                    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                      return 'Please match the email format' ;
                    }
                    if(_alreadyExistEmail) {
                      return 'Already Exist! Try another email';
                    }
                    return null ;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    labelText: 'NAME',
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
                      return 'Enter your name';
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
                    return null;
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
            onPressed: () =>
            {
              widget.verifyEmail(_emailController.text).then((isExist){
                _alreadyExistEmail = isExist ;
              }).then((value){
                if (_formKey.currentState!.validate()) {
                  widget.registerAccount(_emailController.text, _nameController.text,
                  _passwordController.text) ;
                }
              }),
            },
            child: const Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () => widget.startLoginFlow(),
            child: const Text.rich(
              TextSpan(
                text: 'Already a user? ',
                style: TextStyle(color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                      text: 'LOGIN',
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