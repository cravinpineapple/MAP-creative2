import 'package:creative2/model/UserRecord.dart';
import 'package:creative2/screens/todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profileScreen';

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileScreen> {
  _Controller con;
  UserRecord userRecord;
  UserRecord userRecordOriginal;
  bool editMode = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color selectedColor = Colors.grey[300];
  List<int> selected = [];

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
    userRecordOriginal ??=
        ModalRoute.of(context).settings.arguments; // null aware operator assignment
    userRecord ??= UserRecord.clone(userRecordOriginal);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('${userRecord.firstName} ${userRecord.lastName}\'s Profile'),
        actions: [
          editMode
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: con.update,
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: con.edit,
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'First Name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: userRecord.firstName,
                        validator: con.validateName,
                        onSaved: con.saveFirstName,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Last Name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: userRecord.lastName,
                        validator: con.validateName,
                        onSaved: con.saveLastName,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Email',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: userRecord.email,
                        validator: con.validateEmail,
                        onSaved: con.saveEmail,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Password',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: userRecord.password,
                        validator: con.validatePassword,
                        onSaved: con.savePassword,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  thickness: 3.0,
                  color: Colors.grey[800],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: con.buildList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _ProfileState state;
  _Controller(this.state);

  void edit() {
    state.render(() => state.editMode = true);
  }

  void update() {
    if (!state.formKey.currentState.validate()) return;

    for (var id in state.selected) {
      state.userRecord.toDoLists.removeWhere((e) => e.id == id);
    }

    state.formKey.currentState.save();
    state.userRecordOriginal.assign(state.userRecord);

    state.render(() => state.editMode = false);
  }

  String validateName(String value) {
    if (value.length < 2) {
      return 'min 2 chars';
    } else {
      return null;
    }
  }

  void saveFirstName(String value) {
    state.userRecord.firstName = value;
  }

  void saveLastName(String value) {
    state.userRecord.lastName = value;
  }

  void saveEmail(String value) {
    state.userRecord.email = value;
  }

  String validateEmail(String value) {
    bool alreadyExists = false;

    for (var u in UserRecord.fakeDB) {
      if (u.email == value && u.email != state.userRecordOriginal.email) {
        alreadyExists = true;
        break;
      }
    }

    if (value.contains('@') && value.contains('.') && !alreadyExists) return null;

    return alreadyExists ? 'email already exists' : 'email invalid';
  }

  void savePassword(String value) {
    state.userRecord.password = value;
  }

  String validatePassword(String value) {
    if (value.length < 6) return 'password too short';

    return null;
  }

  List<Widget> buildList() {
    if (state.userRecord.toDoLists == null) return [];

    return state.userRecord.toDoLists
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 13.0),
            child: Container(
              width: 370.0,
              height: 65.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.grey[900],
                      width: 5.0,
                    )),
                color: state.selected.contains(e.id) ? Colors.red[400] : Colors.grey[300],
                onLongPress: () {
                  if (state.selected.length == 0) {
                    state.render(() => state.selected.add(e.id));
                  }
                  state.render(() => state.editMode = true);
                },
                onPressed: state.editMode
                    ? () {
                        if (state.selected.contains(e.id)) {
                          state.render(() => state.selected.remove(e.id));
                        } else {
                          state.render(() => state.selected.add(e.id));
                        }
                      }
                    : null,
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
}
