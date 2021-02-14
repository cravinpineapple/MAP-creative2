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

  UserRecord.clone({UserRecord userRecord}) {
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

  static List<UserRecord> fakeDB = [
    UserRecord(
      firstName: 'Eren',
      lastName: 'Jaeger',
      email: '1@test.com',
      password: '111111',
      toDoLists: [
        ToDoList(name: 'Test'),
        ToDoList(name: 'Titans Killed'),
        ToDoList(name: 'Test 2'),
      ],
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
