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
    List builtHierarchy = con.buildListHierarchy(userList.children, 0);

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

  List buildListHierarchy(List<ListItem> children, int indentCount) {
    // iterate through to do list items
    return children
        .map(
          (e) => !e.isFolder
              // placed within row to adjust for slight pixel offset of folder rows
              ? Panel(
                  isFolder: e.isFolder,
                  item: e,
                  toDoCon: this,
                  name: e.name,
                  indentCount:
                      state.userList.children.contains(e) ? 0 : indentCount,
                )
              : // if folder
              //  check if expanded & render accordingly
              // create row with indentation and column with information
              Row(
                  children: [
                    Column(
                      children: [
                        Panel(
                          isFolder: e.isFolder,
                          item: e,
                          name: e.name,
                          toDoCon: this,
                          indentCount: state.userList.children.contains(e)
                              ? 0
                              : indentCount,
                        ),
                        e.isExpanded
                            ? Column(
                                children: buildListHierarchy(
                                    e.children, indentCount + 1),
                              )
                            : SizedBox(height: 0.0, width: 0.0),
                      ],
                    ),
                  ],
                ),
        )
        .toList();
  } // buildListHierarchy

  void toggleExpanded(ListItem item) {
    state.render(() {
      item.isExpanded = !item.isExpanded;
    });
  }

  void addItem(ListItem item) {}

  // void findItem() {}
} // _ToDoController

// custome widget for to do list panels
class Panel extends StatefulWidget {
  // final Widget child;
  final String name;
  final bool isFolder;
  final ListItem item;
  final int indentCount;
  final _ToDoController toDoCon;
  static double indentSize = 50.0;

  Panel({
    @required this.isFolder,
    @required this.item,
    @required this.toDoCon,
    this.name,
    this.indentCount,
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
  _PanelController con;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    con = _PanelController(this, widget.toDoCon);

    // child = widget.child;

    // item = Task(name: 'Task 1', id: 0);
    // item.isExpanded = true;
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    panelColor = item.isFolder ? Colors.grey[600] : Colors.grey[400];
    textColor = item.isFolder ? Colors.white : Colors.grey[800];

    // print('id: ')

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          SizedBox(
              width: widget.indentCount == 0
                  ? 0.0
                  : widget.indentCount * Panel.indentSize),
          Container(
            width: screenWidth - (widget.indentCount * Panel.indentSize) - 20,
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
                  flex: 23,
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
                  flex: 3,
                  child: item.isFolder
                      ? item.isExpanded
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  3.0, 0.0, 0.0, 25.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.expand_more_rounded,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                                onPressed: con.toggleExpanded,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                                onPressed: con.toggleExpanded,
                              ),
                            )
                      : SizedBox(),
                ),
                SizedBox(
                  width: 20.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelController {
  _PanelState state;
  _ToDoController toDoCon;

  _PanelController(this.state, this.toDoCon);

  void toggleExpanded() => state.render(() {
        // toDoCon.state.render(() {
        //   toDoCon.state.userList = toDoCon.state.userList;
        // });
        toDoCon.toggleExpanded(state.item);
        // state.item.isExpanded = !state.item.isExpanded;
      });
}
