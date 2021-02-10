import 'package:creative2/model/ListItem.dart';
import 'package:creative2/model/Task.dart';

class Folder extends ListItem {
  bool isOpen;
  String name;

  Folder({this.isOpen, this.name}) {
    children = [];
  }

  @override
  void createItem({bool isFolder, String name}) {
    if (isFolder) {
      children.add(new Folder(isOpen: false, name: name));
    } else {
      children.add(new Task(isCompleted: false, name: name));
    }
  }

  @override
  void deleteItem() {
    // TODO: implement deleteItem
  }

  String toListString(int tabLength) {
    String tab = '\t';
    String str = (tab * tabLength) + '$name \n';

    for (int i = 0; i < children.length; i++) {
      str += children[i].toListString(tabLength + 1) + '\n';
    }

    return str;
  }
}
