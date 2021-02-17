import 'package:creative2/model/UserRecord.dart';
import 'package:creative2/screens/login_screen.dart';
import 'package:creative2/screens/profile_screen.dart';
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

    if (userRecord.toDoLists.isEmpty) {
      userRecord.toDoLists.add(userRecord.buildTestList('Test 1'));
    }

    List<Widget> builtList = con.buildList();

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('${userRecord.firstName} ${userRecord.lastName}'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: con.goToProfile,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: con.signOut,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Welcome, ${userRecord.firstName} ${userRecord.lastName}'),
          backgroundColor: Colors.grey[600],
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                con.addList(context);
              },
            ),
          ],
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
              height: 65.0,
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
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  void signOut() {
    Navigator.of(state.context).pop(); // closer drawer
    Navigator.of(state.context).pop(); // sign out
  }

  void goToProfile() async {
    await Navigator.pushNamed(state.context, ProfileScreen.routeName,
        arguments: state.userRecord); // goes to profile screen, passing user record
    Navigator.pop(state.context); // closes drawer
    state.render(() {}); // re render due to changes made from profile
  }

  void addList(BuildContext context) {
    print('hello!');

    showDialog(
      context: context,
      barrierDismissible: false,
      child: StatefulBuilder(builder: (context, setState) {
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        String listName;
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.grey[200],
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(state.context),
              color: Colors.grey[800],
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: () {
                if (!formKey.currentState.validate()) return;

                formKey.currentState.save();

                state.render(() {
                  state.userRecord.addToDoList(toDoListName: listName);
                });

                Navigator.pop(context);
              },
              color: Colors.grey[800],
              child: Text(
                'Add',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ],
          content: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'To-Do List Name',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: Theme(
                    data: Theme.of(context).copyWith(primaryColor: Colors.grey[800]),
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey[800]),
                      decoration: InputDecoration(
                        hintText: 'Project, school, etc.',
                      ),
                      keyboardType: TextInputType.name,
                      autocorrect: true,
                      onSaved: (String value) {
                        listName = value;
                      },
                      validator: (String value) {
                        print('validate: $value');
                        if (value.length > 15)
                          return 'Name too long';
                        else
                          return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
