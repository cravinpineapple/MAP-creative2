import 'package:creative2/model/ToDoList.dart';

class UserRecord {
  String name;
  String email;
  String password;
  List<ToDoList> toDoLists = new List<ToDoList>();

  UserRecord({this.name, this.email, this.password});

  UserRecord.clone({UserRecord userRecord}) {
    this.name = userRecord.name;
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

  static List<UserRecord> fakeDB = [
    UserRecord(
      name: 'Eren',
      email: '1@test.com',
      password: '111111',
    ),
    UserRecord(
      name: 'Mikasa',
      email: '2@test.com',
      password: '222222',
    ),
    UserRecord(
      name: 'Armin',
      email: '3@test.com',
      password: '333333',
    ),
  ];
}
