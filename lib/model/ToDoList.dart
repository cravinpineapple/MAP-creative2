import 'package:creative2/model/Folder.dart';
import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';

class ToDoList {
  static int globalListCounter = 0;

  List<ListItem> children = [];
  String name;
  int id = 0;
  int localID = 0;
  int idCount = 0;

  ToDoList({this.name}) {
    this.name = name;
    this.id = globalListCounter++;
  }

  // provide if item will be folder, it's name, and the ID of what it's parent will be
  void addItem({bool isFolder, String name, int addID = 0}) {
    idCount++;

    // if adding to root
    if (0 == addID) {
      if (isFolder) {
        children.add(new Folder(name: name, id: idCount));
      } else {
        children.add(new Task(name: name, id: idCount));
      }

      return;
    }

    // if adding to sub-root
    for (int i = 0; i < children.length; i++) {
      if (children[i].isFolder) {
        children[i].addItem(isFolder: isFolder, name: name, addID: addID, newID: idCount);
      }
    }
  }

  // provide id of ListItem to be deleted.
  //  searches until deleted
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
    String str = '$name=======================\n';

    for (int i = 0; i < children.length; i++) {
      str += children[i].toListString(1) + '\n';
    }

    return str;
  }
}
