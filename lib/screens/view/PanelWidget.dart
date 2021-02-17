// custome widget for to do list panels
import 'package:creative2/model/ListItem.dart';
import 'package:creative2/screens/todo_screen.dart';
import 'package:flutter/material.dart';

class Panel extends StatefulWidget {
  final bool isFolder;
  final ListItem item;
  final int indentCount;
  final ToDoController toDoCon;
  static double indentSize = 50.0;

  Panel({
    @required this.isFolder,
    @required this.item,
    @required this.toDoCon,
    this.indentCount,
  });

  @override
  State<StatefulWidget> createState() {
    return PanelState();
  }
}

class PanelState extends State<Panel> {
  ListItem item;
  double screenWidth;
  Color panelColor;
  Color textColor;
  ToDoController con;
  String name;

  // for add dialog check box
  bool addDialogCheck = false;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    con = widget.toDoCon;
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    name = item.name;
    screenWidth = MediaQuery.of(context).size.width;
    panelColor = item.isFolder ? Colors.grey[600] : Colors.grey[400];
    textColor = item.isFolder ? Colors.white : Colors.grey[800];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          SizedBox(
              width:
                  widget.indentCount == 0 ? 0.0 : widget.indentCount * Panel.indentSize),
          Container(
            width: screenWidth - (widget.indentCount * Panel.indentSize) - 20,
            height: 50.0,
            decoration: BoxDecoration(
              color: panelColor,
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(5.0, 5.0),
                  blurRadius: 2.0,
                  color: Colors.black,
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
                        flex: 8,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                item.isToggled = value;
                              });
                            },
                            value: item.isToggled,
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
                    name,
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
                          onPressed: () {
                            if (item.depth == 2)
                              con.maxDepthDialog(this);
                            else
                              con.addDialog(this);
                          },
                        )
                      : SizedBox(),
                ),
                // drop down or delete icon
                Expanded(
                  flex: 3,
                  // if item is folder display respective folder icon. if not, display nothing
                  child: item.isFolder
                      ? item.children.isEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 36.0,
                                color: item.children.isEmpty ? Colors.white : panelColor,
                              ),
                              onPressed: item.children.isEmpty
                                  ? () {
                                      con.removeItem(item.id);
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder:
                                              (context, animation1, animation2) =>
                                                  ToDoScreen(
                                            toDoReplace: con.state.userList,
                                          ),
                                          transitionDuration: Duration(seconds: 0),
                                        ),
                                      );
                                    }
                                  : null,
                            )
                          // if item is folder display drop down icon
                          : item.isToggled
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 25.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.expand_more_rounded,
                                      size: 35.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      con.toggleExpanded(item);
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 35.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      con.toggleExpanded(item);
                                    },
                                  ),
                                )
                      : SizedBox(),
                ),
                // if check box and is completed, display delete icon
                !item.isFolder
                    ? Expanded(
                        flex: 7,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 36.0,
                            color: item.isToggled ? Colors.white : panelColor,
                          ),
                          onPressed: item.isToggled
                              ? () {
                                  con.removeItem(item.id);
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) =>
                                          ToDoScreen(
                                        toDoReplace: con.state.userList,
                                      ),
                                      transitionDuration: Duration(seconds: 0),
                                    ),
                                  );
                                }
                              : null,
                        ),
                      )
                    : SizedBox(),
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
