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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.0),
            Row(
              children: [
                SizedBox(width: 30.0),
                Container(
                  width: 350.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[700],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        offset: Offset(10.0, 10.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 19.0, 0.0, 0.0),
                    child: Text(
                      'To - Do',
                      style: TextStyle(
                        fontSize: 100.0,
                        color: Colors.white,
                        fontFamily: 'Robot',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0),
            Row(
              children: [
                SizedBox(width: 50.0),
                Column(
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: Colors.white),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'levi.ackerman@scouts.com',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onSaved: null,
                          validator: null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: Colors.white),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            icon: Icon(Icons.security),
                            hintText: 'password123',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onSaved: null,
                          validator: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  LoginScreenState state;

  _Controller(this.state);
}
