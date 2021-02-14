import 'package:creative2/model/UserRecord.dart';
import 'package:creative2/screens/todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  UserRecord userRecord;
  _Controller con;

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
    userRecord = ModalRoute.of(context).settings.arguments;

    if (userRecord.toDoLists.isEmpty)
      userRecord.toDoLists.add(userRecord.buildTestList());

    List<Widget> builtList = con.buildList();

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Welcome, ${userRecord.firstName} ${userRecord.lastName}'),
        backgroundColor: Colors.grey[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Column(
            children: builtList.length != 0
                ? builtList
                : [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 240.0,
                        left: 22.0,
                        // right: 35.0,
                      ),
                      child: Text(
                        'You currently have no to-do lists.\nClick the + to create one!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _HomeScreenState state;

  _Controller(this.state);

  List<Widget> buildList() {
    if (state.userRecord.toDoLists == null) return [];

    return state.userRecord.toDoLists
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 13.0),
            child: Container(
              width: 370.0,
              height: 75.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.grey[900],
                      width: 5.0,
                    )),
                color: Colors.grey[300],
                onPressed: () => Navigator.pushNamed(
                  state.context,
                  ToDoScreen.routeName,
                  arguments: e, // passing in the to do list
                ),
                child: Text(
                  e.name,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
