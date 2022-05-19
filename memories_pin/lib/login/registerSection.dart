import 'package:flutter/material.dart' ;

class RegisterSection extends StatelessWidget {
  RegisterSection({Key? key,
    required this.cancelLoginFlow,
    required this.startLoginFlow,
  }) : super(key: key) ;
  final TextEditingController _loginIdController = TextEditingController() ;
  final TextEditingController _passwordController = TextEditingController() ;
  final void Function() cancelLoginFlow ;
  final void Function() startLoginFlow ;

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
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () => startLoginFlow(),
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