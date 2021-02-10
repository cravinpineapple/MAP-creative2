import 'package:creative2/model/Folder.dart';
import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';

class ToDoList {
  List<ListItem> children = [];
  String name;
  static int idCount = 0;

  ToDoList({this.name}) {
    this.name = name;
  }

  void addItem({bool isFolder, String name}) {
    if (isFolder) {
      children.add(new Folder(name: name));
    } else {
      children.add(new Task(name: name));
    }
  }

  void deleteItem({int deleteID}) {
    for (int i = 0; i < children.length; i++) {
      print('${children[i].id}');

      if (children[i].id == deleteID) {
        children.removeAt(i);
        // successful delete, stop searching
        return;
      } else if (children[i].isFolder) {
        // if deleted (returns true), we stop searching
        if (children[i].deleteItem(deleteID: deleteID)) return;
      }
    }
  }

  @override
  String toString() {
    String str = '$name \n';

    for (int i = 0; i < children.length; i++) {
      str += children[i].toListString(1) + '\n';
    }

    return str;
  }
}
