import 'package:creative2/model/Folder.dart';
import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';

class ToDoList {
  List<ListItem> children = [];
  String name;

  ToDoList({this.name}) {
    this.name = name;
  }

  void addItem({bool isFolder, String name}) {
    if (isFolder) {
      children.add(new Folder(isOpen: false, name: name));
    } else {
      children.add(new Task(isCompleted: false, name: name));
    }
  }

  void deleteItem({bool isFolder}) {}

  @override
  String toString() {
    String str = '$name \n';

    for (int i = 0; i < children.length; i++) {
      str += children[i].toListString(1) + '\n';
    }

    return str;
  }
}
