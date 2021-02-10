import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';
import 'package:creative2/model/ToDoList.dart';

class Folder extends ListItem {
  bool isOpen;
  String name;
  bool hasChildren;

  Folder({this.name}) {
    this.isFolder = true;
    children = [];
    isOpen = false;
    id = ++ToDoList.idCount;
    hasChildren = false;
  }

  @override
  void createItem({bool isFolder, String name}) {
    // adds either folder or task into the children
    if (isFolder) {
      children.add(new Folder(name: name));
    } else {
      children.add(new Task(name: name));
    }

    hasChildren = true;
  }

  @override
  bool deleteItem({int deleteID}) {
    for (int i = 0; i < children.length; i++) {
      print('${children[i].id}');
      // delete ID found & is folder
      if (children[i].id == deleteID) {
        children.removeAt(i);
        // update status of children due to deleton
        hasChildren = children.length != 0 ? true : false;
        // deleted, so signal up to list to stop search
        return true;
      } else if (children[i].isFolder) {
        // if deleted, signal up to list to stop search
        return children[i].deleteItem(deleteID: deleteID);
      }
    }

    return false;
  }

  void deleteCascade({int deleteID}) {
    for (int i = 0; i < children[deleteID].children.length; i++) {}
  }

  String toListString(int tabLength) {
    String tab = '\t';
    String str = (tab * tabLength) + '$name [id = $id]\n';

    for (int i = 0; i < children.length; i++) {
      str += children[i].toListString(tabLength + 1);
    }

    return str;
  }
}
