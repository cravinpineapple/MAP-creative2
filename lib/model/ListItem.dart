abstract class ListItem {
  bool isFolder;
  bool isExpanded;
  List<ListItem> children = [];
  int id;

  ListItem({
    this.isFolder = false,
  });

  bool deleteItem({int deleteID});
  void addItem({bool isFolder, String name, int addID, int newID});
  String toListString(int tabLength);
}
