abstract class ListItem {
  bool isFolder;
  List<ListItem> children = [];

  ListItem({
    this.isFolder = false,
  });

  void deleteItem();
  void createItem({bool isFolder, String name});
  String toListString(int tabLength);
}
