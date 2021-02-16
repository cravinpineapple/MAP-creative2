import 'package:creative2/model/UserRecord.dart';
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
    userRecordOriginal ??= ModalRoute.of(context)
        .settings
        .arguments; // null aware operator assignment
    userRecord ??= UserRecord.clone(userRecordOriginal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title:
            Text('${userRecord.firstName} ${userRecord.lastName}\'s Profile'),
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
                      flex: 1,
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
                      flex: 1,
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
                      flex: 1,
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
                        onSaved: con.validateEmail,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
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
      if (u.email == value) {
        alreadyExists = true;
        break;
      }
    }

    if (value.contains('@') && value.contains('.') && !alreadyExists)
      return null;

    return alreadyExists ? 'email already exists' : 'email invalid';
  }

  void savePassword(String value) {
    state.userRecord.password = value;
  }

  String validatePassword(String value) {
    if (value.length < 6) return 'password too short';

    return null;
  }
}
