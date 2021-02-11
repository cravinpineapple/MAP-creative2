import 'package:creative2/model/Folder.dart';
import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';
import 'package:creative2/model/ToDoList.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ToDoScreen extends StatefulWidget {
  static const routeName = '/toDoScreen';

  @override
  State<StatefulWidget> createState() {
    return _ToDoState();
  }
}

class _ToDoState extends State<ToDoScreen> {
  ToDoList userList;
  _ToDoController con;

  @override
  void initState() {
    super.initState();
    userList = ToDoList();
    con = _ToDoController(this);
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User\'s To-Do List'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: null),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Panel(
              isFolder: false,
              name: 'Task 1',
            ),
          ],
        ),
      ),
    );
  }
}

class _ToDoController {
  _ToDoState state;

  _ToDoController(this.state);
}

// custome widget for to do list panels
class Panel extends StatefulWidget {
  // final Widget child;
  final String name;
  final bool isFolder;

  Panel({@required this.isFolder, this.name});

  @override
  State<StatefulWidget> createState() {
    return _PanelState();
  }
}

class _PanelState extends State<Panel> {
  ListItem item;

  @override
  void initState() {
    super.initState();
    item = Folder(name: 'Task 1', id: 0);
    item.isExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            flex: 20,
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            flex: 4,
            child: item.isFolder
                ? IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 36.0,
                      color: Colors.white,
                    ),
                    onPressed: null,
                  )
                : SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: item.isFolder
                ? item.isExpanded
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 25.0),
                        child: IconButton(
                            icon: Transform.rotate(
                              angle: math.pi / 2,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: null),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            onPressed: null),
                      )
                : SizedBox(),
          ),
          SizedBox(
            width: 30.0,
          )
        ],
      ),
    );
  }
}
