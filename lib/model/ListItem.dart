abstract class ListItem {
  bool isFolder;
  // acts as isExpanded for folder, and isCompleted for checkbox
  bool isToggled;
  String name;
  List<ListItem> children = [];
  int id;
  int depth;

  ListItem({
    this.isFolder = false,
  });

  bool deleteItem({int deleteID});
  void addItem({bool isFolder, String name, int addID, int newID, int depth});
  String toListString(int tabLength);
}
