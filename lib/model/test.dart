import 'package:creative2/model/ToDoList.dart';

void main() {
  var list = ToDoList(name: 'My List');

  list.addItem(isFolder: false, name: 'Task 1');
  list.addItem(isFolder: true, name: 'Folder 1');
  list.children[1].createItem(isFolder: true, name: 'Folder 1-1');
  list.children[1].children[0].createItem(isFolder: false, name: 'Task 1-1-1');
  list.children[1].children[0].createItem(isFolder: false, name: 'Task 1-1-2');
  list.children[1].children[0].createItem(isFolder: false, name: 'Task 1-1-3');
  list.children[0].createItem(isFolder: false, name: 'Task 1-1');
  list.addItem(isFolder: false, name: 'Task 2');
  list.addItem(isFolder: true, name: 'Folder 2');
  list.children[3].createItem(isFolder: true, name: 'Folder 2-1');
  list.children[3].createItem(isFolder: true, name: 'Folder 2-2');
  list.children[3].createItem(isFolder: true, name: 'Folder 2-3');
  list.children[3].createItem(isFolder: false, name: 'Task 2-1');

  list.children[3].children[1].createItem(isFolder: true, name: 'Folder 2-2-1');
  list.children[3].children[1].children[0]
      .createItem(isFolder: true, name: 'Folder 2-2-1-1');
  list.children[3].children[1].children[0].children[0]
      .createItem(isFolder: true, name: 'Folder 2-2-1-1-1');

  print(list.toString());

  list.deleteItem(deleteID: 5);
  list.deleteItem(deleteID: 10);
  print('\n======================\n');
  print(list.toString());
}
