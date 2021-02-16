abstract class ListItem {
  bool isFolder;
  // acts as isExpanded for folder, and isCompleted for checkbox
  bool isToggled;
  String name;
  List<ListItem> children = [];
  int id;

  ListItem({
    this.isFolder = false,
  });

  bool deleteItem({int deleteID});
  void addItem({bool isFolder, String name, int addID, int newID});
  String toListString(int tabLength);
}
