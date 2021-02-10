import 'ListItem.dart';

class Task extends ListItem {
  bool isCompleted;
  String name;

  Task({this.isCompleted, this.name}) {
    children = null;
  }

  @override
  void createItem({bool isFolder, String name}) {}

  @override
  void deleteItem() {}

  @override
  String toListString(int tabLength) {
    String tab = '\t';

    return (tab * tabLength) + name;
  }
}
