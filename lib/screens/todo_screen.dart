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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: Column(
            children: [
              Panel(
                isFolder: false,
                name: 'test',
              ),
            ],
          ),
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
  final GlobalKey _panelKey = GlobalKey();
  double screenWidth;
  Color panelColor;
  Color textColor;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
    item = Task(name: 'Task 1', id: 0);
    item.isExpanded = true;
    // WidgetsBinding.instance.addPostFrameCallback((_) => getPosition());
  }

  // Offset panelPosition;
  // gets position of widget AFTER render
  // getPosition() {
  //   RenderBox _panelBox = _panelKey.currentContext.findRenderObject();
  //   panelPosition = _panelBox.localToGlobal(Offset.zero);
  // }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    panelColor = item.isFolder ? Colors.grey[600] : Colors.grey[400];
    textColor = item.isFolder ? Colors.white : Colors.grey[800];

    return Container(
      key: _panelKey,
      width: screenWidth,
      height: 50.0,
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(5.0, 5.0),
            blurRadius: 2.0,
            color: Colors.grey[600],
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: item.isFolder ? 15.0 : 5.0,
          ),
          // Display checkbox if task
          !item.isFolder
              ? Expanded(
                  flex: 4,
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      onChanged: (bool value) {
                        setState(() {
                          checkedValue = value;
                        });
                      },
                      value: checkedValue,
                      checkColor: Colors.grey[800],
                      activeColor: panelColor,
                    ),
                  ),
                )
              : SizedBox(),
          // Displaying item text
          Expanded(
            flex: 20,
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: 28.0,
                fontFamily: 'Roboto',
                color: textColor,
              ),
            ),
          ),
          // if item is folder display add icon
          Expanded(
            flex: 3,
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
          // if item is folder display drop down icon
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
            width: 20.0,
          )
        ],
      ),
    );
  }
}
