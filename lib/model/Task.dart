import 'ListItem.dart';
import 'ToDoList.dart';

class Task extends ListItem {
  bool isCompleted;
  String name;

  Task({this.name, int id}) {
    this.isFolder = false;
    children = null;
    this.id = id;
  }

  @override
  void createItem({bool isFolder, String name}) {}

  @override
  bool deleteItem({int deleteID}) {
    return false;
  }

  @override
  String toListString(int tabLength) {
    String tab = '\t';

    return (tab * tabLength) + name + ' [id = $id]\n';
  }
}
