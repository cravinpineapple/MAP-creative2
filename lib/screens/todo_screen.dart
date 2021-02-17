import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/ToDoList.dart';
import 'package:creative2/screens/view/PanelWidget.dart';
import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  static const routeName = '/toDoScreen';
  final ToDoList toDoReplace;

  // paremeter passed for pushReplacement (on deletion)
  ToDoScreen({this.toDoReplace});

  @override
  State<StatefulWidget> createState() {
    return _ToDoState(userList: this.toDoReplace);
  }
}

class _ToDoState extends State<ToDoScreen> {
  ToDoList userList;
  ToDoController con;

  // parameter for pushReplacement (on deletion)
  _ToDoState({this.userList});

  @override
  void initState() {
    super.initState();
    con = ToDoController(this);
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    userList ??= ModalRoute.of(context).settings.arguments;
    List builtHierarchy = con.buildListHierarchy(userList.children, 0);

    print(userList);

    return Scaffold(
      appBar: AppBar(
        title: Text('${userList.name}'),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              con.addDialog(null);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: Column(
            children: builtHierarchy,
          ),
        ),
      ),
    );
  }
}

class ToDoController {
  _ToDoState state;

  ToDoController(this.state);

  List buildListHierarchy(List<ListItem> children, int indentCount) {
    // iterate through to do list items
    var builtList = children
        .map(
          (e) => !e.isFolder
              // placed within row to adjust for slight pixel offset of folder rows
              ? Panel(
                  isFolder: e.isFolder,
                  item: e,
                  toDoCon: this,
                  indentCount: state.userList.children.contains(e) ? 0 : indentCount,
                )
              : // if folder
              //   check if expanded & render accordingly
              //   create row with indentation and column with information
              Row(
                  children: [
                    Column(
                      children: [
                        Panel(
                          isFolder: e.isFolder,
                          item: e,
                          toDoCon: this,
                          indentCount:
                              state.userList.children.contains(e) ? 0 : indentCount,
                        ),
                        e.isToggled
                            ? Column(
                                children: buildListHierarchy(e.children, indentCount + 1),
                              )
                            : SizedBox(height: 0.0, width: 0.0),
                      ],
                    ),
                  ],
                ),
        )
        .toList();

    return builtList;
  } // buildListHierarchy

  void toggleExpanded(ListItem item) {
    state.render(() {
      item.isToggled = !item.isToggled;
    });
  }

  void removeItem(int deleteID) {
    state.render(() {
      state.userList.deleteItem(deleteID: deleteID);
    });
  }

  void addDialog(PanelState panelState) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    bool isFolder = false;
    String itemName = '';

    showDialog(
      context: state.context,
      barrierDismissible: false,
      builder: (context) {
        bool checkedValue = false;
        return StatefulBuilder(builder: (context, setState) {
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
                    int addID = panelState != null ? panelState.item.id : 0;
                    state.userList
                        .addItem(isFolder: isFolder, name: itemName, addID: addID);
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
                    'Name',
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
                          hintText: 'Groceries, carrots, etc...',
                        ),
                        keyboardType: TextInputType.name,
                        autocorrect: true,
                        onSaved: (String value) {
                          isFolder = checkedValue;
                          itemName = value;
                        },
                        validator: (String value) {
                          if (value.length > 10)
                            return 'Name too long';
                          else
                            return null;
                        },
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text(
                      'Folder',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20.0,
                      ),
                    ),
                    value: checkedValue,
                    onChanged: (bool value) => setState(() {
                      checkedValue = value;
                    }),
                    checkColor: Colors.grey[800],
                    activeColor: Colors.grey[200],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void maxDepthDialog(PanelState pState) {
    showDialog(
      context: state.context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.grey[200],
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(state.context),
              color: Colors.grey[800],
              child: Text(
                'Ok',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ],
          content: Text(
            'Max Folder Depth Reached',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 25.0,
            ),
          ),
        );
      },
    );
  }

  void addItem(ListItem item) {}

  // void findItem() {}
} // _ToDoController
