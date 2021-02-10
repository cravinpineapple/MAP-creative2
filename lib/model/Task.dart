import 'ListItem.dart';
import 'ToDoList.dart';

class Task extends ListItem {
  bool isCompleted;
  String name;

  Task({this.name}) {
    this.isFolder = false;
    children = null;
    id = ++ToDoList.idCount;
  }

  @override
  void createItem({bool isFolder, String name}) {}

  @override
  void deleteItem({int deleteID}) {}

  @override
  String toListString(int tabLength) {
    String tab = '\t';

    return (tab * tabLength) + name + ' [id = $id]\n';
  }
}
