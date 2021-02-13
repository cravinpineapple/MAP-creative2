import 'package:creative2/screens/home_screen.dart';
import 'package:creative2/screens/login_screen.dart';
import 'package:creative2/screens/todo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Creative2App());
}

class Creative2App extends StatelessWidget {
  static bool lightMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Creative2App'),
      title: 'Creative Assignment 2',
      theme: ThemeData(
        brightness: lightMode ? Brightness.light : Brightness.dark,
        // primaryColor: Colors.grey[700],
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
            // fontFamily: 'Roboto',
          ),
        ),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        ToDoScreen.routeName: (context) => ToDoScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
