import 'package:creative2/model/UserRecord.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                // logo
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
                SizedBox(width: 70.0),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      // Error message if inputted account information invalid
                      error == null
                          ? SizedBox()
                          : Text(
                              error,
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 15.0,
                              ),
                            ),
                      SizedBox(
                        width: 260.0,
                        child: Theme(
                          data: Theme.of(context).copyWith(primaryColor: Colors.white),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'levi.ackerman@scouts.com',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            onSaved: con.emailSave,
                            validator: con.emailValidate,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 260.0,
                        child: Theme(
                          data: Theme.of(context).copyWith(primaryColor: Colors.white),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              icon: Icon(Icons.security),
                              hintText: 'password123',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            onSaved: con.passwordSave,
                            validator: con.passwordValidate,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.grey[600],
                        onPressed: con.login,
                        splashColor: Colors.white,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
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
  _LoginScreenState state;
  UserRecord userRecord = UserRecord();

  _Controller(this.state);

  void emailSave(String value) {
    userRecord.email = value;
  }

  String emailValidate(String value) {
    if (value.contains('@') && value.contains('.')) return null;

    return 'email invalid';
  }

  void passwordSave(String value) {
    userRecord.password = value;
  }

  String passwordValidate(String value) {
    if (value.length < 6) return 'password too short';

    return null;
  }

  void login() {
    // check if email / password are valid
    state.render(() => state.error = null);
    if (!state.formKey.currentState.validate()) return;

    // email / password format is valid, now save information.
    state.formKey.currentState.save();

    for (var u in UserRecord.fakeDB) {
      print('Name: ${u.firstName} ${u.lastName}');
      print('Email: ${u.email}');
      print('Password: ${u.password}');
      print('======================');
    }

    var user = UserRecord.fakeDB.firstWhere(
        (e) => e.email == userRecord.email && e.password == userRecord.password,
        orElse: () => null);

    if (user == null) {
      state.render(() => state.error = 'email or password invalid');
    } else {
      state.render(() => state.error = null);
      Navigator.pushNamed(state.context, HomeScreen.routeName, arguments: user);
    }
  }
}
