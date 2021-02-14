import 'package:creative2/model/ListItem.dart';
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
    con = _ToDoController(this);
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    userList = ModalRoute.of(context).settings.arguments;
    List builtHierarchy = con.buildListHierarchy(userList.children, 10.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('User\'s To-Do List'),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: null),
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

class _ToDoController {
  _ToDoState state;

  _ToDoController(this.state);

  List buildListHierarchy(List<ListItem> children, double currentIndent) {
    // iterate through to do list items
    return children
        .map(
          (e) => !e.isFolder
              // placed within row to adjust for slight pixel offset of folder rows
              ? Row(
                  children: [
                    Panel(
                      isFolder: e.isFolder,
                      item: e,
                      name: e.name,
                      indent: currentIndent,
                    ),
                  ],
                )
              : // if folder
              // create row with indentation and column with information
              Row(
                  children: [
                    SizedBox(
                        width:
                            state.userList.children.contains(e) ? 0.0 : 30.0),
                    Column(
                      children: [
                        Panel(
                          isFolder: e.isFolder,
                          item: e,
                          name: e.name,
                          indent: state.userList.children.contains(e)
                              ? 10.0
                              : currentIndent,
                        ),
                        Column(
                          children: buildListHierarchy(
                              e.children, currentIndent + 30.0),
                        )
                      ],
                    ),
                  ],
                ),
        )
        .toList();
  } // buildListHierarchy

} // _ToDoController

// custome widget for to do list panels
class Panel extends StatefulWidget {
  // final Widget child;
  final String name;
  final bool isFolder;
  final ListItem item;
  final double indent;

  Panel({
    @required this.isFolder,
    @required this.item,
    this.name,
    this.indent,
  });

  @override
  State<StatefulWidget> createState() {
    return _PanelState();
  }
}

class _PanelState extends State<Panel> {
  ListItem item;
  double screenWidth;
  Color panelColor;
  Color textColor;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    // child = widget.child;

    // item = Task(name: 'Task 1', id: 0);
    // item.isExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    panelColor = item.isFolder ? Colors.grey[600] : Colors.grey[400];
    textColor = item.isFolder ? Colors.white : Colors.grey[800];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: screenWidth - widget.indent - 15,
        height: 50.0,
        decoration: BoxDecoration(
          color: panelColor,
          borderRadius: BorderRadius.circular(7.0),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(5.0, 5.0),
          //     blurRadius: 2.0,
          //     color: Colors.grey[600],
          //   ),
          // ],
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
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 25.0),
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
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
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
      ),
    );
  }
}
