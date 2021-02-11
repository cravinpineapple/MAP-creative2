import 'package:creative2/screens/todo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Creative2App());
}

class Creative2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Creative2App'),
      title: 'Creative Assignment 2',
      initialRoute: ToDoScreen.routeName,
      routes: {
        ToDoScreen.routeName: (context) => ToDoScreen(),
      },
    );
  }
}
