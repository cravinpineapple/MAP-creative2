abstract class ListItem {
  bool isFolder;
  List<ListItem> children = [];
  int id;

  ListItem({
    this.isFolder = false,
  });

  void deleteItem({int deleteID});
  void createItem({bool isFolder, String name});
  String toListString(int tabLength);
}
