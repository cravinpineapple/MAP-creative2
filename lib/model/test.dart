import 'package:creative2/model/ToDoList.dart';

void main() {
  var list = ToDoList(name: 'My List');

  // Task 1
  list.addItem(isFolder: false, addID: 0, name: 'Task 1');

  // Folder 1
  list.addItem(isFolder: true, addID: 0, name: 'Folder 1');
  list.addItem(isFolder: true, addID: 2, name: 'Folder 1-1');
  list.addItem(isFolder: false, addID: 3, name: 'Task 1-1-1');
  list.addItem(isFolder: false, addID: 3, name: 'Task 1-1-2');
  list.addItem(isFolder: false, addID: 3, name: 'Task 1-1-3');

  // Task 2
  list.addItem(isFolder: false, addID: 0, name: 'Task 2');

  // Folder 2
  list.addItem(isFolder: true, addID: 0, name: 'Folder 2');
  list.addItem(isFolder: true, addID: 8, name: 'Folder 2-1');
  list.addItem(isFolder: true, addID: 8, name: 'Folder 2-2');
  list.addItem(isFolder: true, addID: 8, name: 'Folder 2-2');
  list.addItem(isFolder: false, addID: 8, name: 'Task 2-1');

  list.addItem(isFolder: true, addID: 10, name: 'Folder 2-2-1');
  list.addItem(isFolder: true, addID: 13, name: 'Folder 2-2-1-1');
  list.addItem(isFolder: true, addID: 14, name: 'Folder 2-2-1-1-1');

  print(list.toString());

  // list.deleteItem(deleteID: 4);
  // // list.deleteItem(deleteID: 10);
  // print('\n======================\n');
  // print(list.toString());
}
