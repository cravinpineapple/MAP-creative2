import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  _Controller con;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String error;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            style: TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontFamily: 'Roboto',
            ),
          ),
          // TextFormField(
          //   decoration: InputDecoration(),
          // ),
        ],
      ),
    );
  }
}

class _Controller {
  LoginScreenState state;

  _Controller(this.state);
}
