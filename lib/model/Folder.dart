import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';
import 'package:creative2/model/ToDoList.dart';

class Folder extends ListItem {
  bool isOpen;
  String name;
  bool hasChildren;

  Folder({this.name, int id}) {
    this.isFolder = true;
    children = [];
    isOpen = false;
    this.id = id;
    hasChildren = false;
    isToggled = false;
  }

  @override
  void addItem({bool isFolder, String name, int addID, int newID}) {
    hasChildren = true;

    // if adding to root
    if (this.id == addID) {
      if (isFolder) {
        children.add(new Folder(name: name, id: newID));
      } else {
        children.add(new Task(name: name, id: newID));
      }

      return;
      // true;
    }

    // if adding to sub-root
    for (int i = 0; i < children.length; i++) {
      if (children[i].isFolder) {
        children[i].addItem(isFolder: isFolder, name: name, addID: addID, newID: newID);
      }
    }
  }

  @override
  bool deleteItem({int deleteID}) {
    for (int i = 0; i < children.length; i++) {
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
    String str = (tab * tabLength) + '$name [id = $id, exp = $isToggled]\n';

    for (int i = 0; i < children.length; i++) {
      str += children[i].toListString(tabLength + 1);
    }

    return str;
  }
}
