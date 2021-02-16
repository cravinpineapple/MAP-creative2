import 'package:creative2/model/ToDoList.dart';

class UserRecord {
  String firstName;
  String lastName;
  String email;
  String password;
  List<ToDoList> toDoLists;

  UserRecord(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.toDoLists});

  UserRecord.clone(UserRecord userRecord) {
    this.firstName = userRecord.firstName;
    this.lastName = userRecord.lastName;
    this.email = userRecord.email;
    this.password = userRecord.password;

    this.toDoLists = [];
    // ** might need to copy deeper
    for (int i = 0; i < userRecord.toDoLists.length; i++) {
      this.toDoLists[i] = userRecord.toDoLists[i];
    }
  }

  void addToDoList({String toDoListName}) {
    toDoLists.add(new ToDoList(name: toDoListName));
  }

  void removeToDoList({int removeID}) {
    toDoLists.removeWhere((e) => e.id == removeID);
  }

  // ** temp
  ToDoList buildTestList() {
    ToDoList newToDoList = ToDoList(name: 'Test');

    newToDoList.addItem(name: 'Folder 1', isFolder: true, addID: 0);
    newToDoList.addItem(name: 'Task 1', isFolder: false, addID: 0);
    newToDoList.addItem(name: 'Task 2', isFolder: false, addID: 0);
    newToDoList.addItem(name: 'Folder 2', isFolder: true, addID: 0);
    newToDoList.addItem(name: 'Folder 2-1', isFolder: true, addID: 4);
    newToDoList.addItem(name: 'Task 2-1-1', isFolder: false, addID: 5);
    newToDoList.addItem(name: 'Task 2-1-2', isFolder: false, addID: 5);
    newToDoList.addItem(name: 'Task 2-1-3', isFolder: false, addID: 5);
    newToDoList.addItem(name: 'Folder 2-2', isFolder: true, addID: 4);
    newToDoList.addItem(name: 'Folder 2-2-1', isFolder: true, addID: 9);
    newToDoList.addItem(name: 'Task 2-2-1-1', isFolder: false, addID: 10);

    newToDoList.addItem(name: 'Task 3', isFolder: false, addID: 0);
    newToDoList.addItem(name: 'Task 4', isFolder: false, addID: 0);
    newToDoList.addItem(name: 'Task 5', isFolder: false, addID: 0);

    newToDoList.addItem(name: 'Folder 2-1-1', isFolder: true, addID: 5);
    newToDoList.addItem(name: 'Task 2-1-1-1', isFolder: false, addID: 16);
    newToDoList.addItem(name: 'Task 2-1-1-2', isFolder: false, addID: 16);

    return newToDoList;
  }

  static List<UserRecord> fakeDB = [
    UserRecord(
      firstName: 'Eren',
      lastName: 'Jaeger',
      email: '1@test.com',
      password: '111111',
      toDoLists: [],
    ),
    UserRecord(
      firstName: 'Mikasa',
      lastName: 'Ackerman',
      email: '2@test.com',
      password: '222222',
    ),
    UserRecord(
      firstName: 'Armin',
      lastName: 'Arlert',
      email: '3@test.com',
      password: '333333',
    ),
  ];
}
