import 'package:creative2/model/ToDoList.dart';

class UserRecord {
  String firstName;
  String lastName;
  String email;
  String password;
  List<ToDoList> toDoLists;

  UserRecord({this.firstName, this.lastName, this.email, this.password, this.toDoLists});

  UserRecord.clone(UserRecord userRecord) {
    this.firstName = userRecord.firstName;
    this.lastName = userRecord.lastName;
    this.email = userRecord.email;
    this.password = userRecord.password;

    this.toDoLists = [];
    // ** might need to copy deeper
    for (int i = 0; i < userRecord.toDoLists.length; i++) {
      this.toDoLists.add(userRecord.toDoLists[i]);
    }
  }

  void assign(UserRecord userRecord) {
    this.firstName = userRecord.firstName;
    this.lastName = userRecord.lastName;
    this.email = userRecord.email;
    this.password = userRecord.password;

    this.toDoLists = [];
    // ** might need to copy deeper
    for (int i = 0; i < userRecord.toDoLists.length; i++) {
      this.toDoLists.add(userRecord.toDoLists[i]);
    }
  }

  void addToDoList({String toDoListName}) {
    toDoLists.add(new ToDoList(name: toDoListName));
  }

  void removeToDoList({int removeID}) {
    toDoLists.removeWhere((e) => e.id == removeID);
  }

  // ** temp
  ToDoList buildTestList(String name) {
    ToDoList newToDoList = ToDoList(name: name);

    if (name == 'Groceries') {
      newToDoList.addItem(name: 'Weekly', isFolder: true, addID: 0);
      newToDoList.addItem(name: 'Milk', isFolder: false, addID: 1);
      newToDoList.addItem(name: 'Bread', isFolder: false, addID: 1);
      newToDoList.addItem(name: 'Eggs', isFolder: false, addID: 1);
      newToDoList.addItem(name: 'Sweets', isFolder: true, addID: 1);
      newToDoList.addItem(name: 'Hi-Chews', isFolder: false, addID: 5);
      newToDoList.addItem(name: 'LaffyTaffy', isFolder: false, addID: 5);
      newToDoList.addItem(name: 'Veggies', isFolder: true, addID: 1);
      newToDoList.addItem(name: 'Carrots', isFolder: false, addID: 8);
      newToDoList.addItem(name: 'Onions', isFolder: false, addID: 8);
      newToDoList.addItem(name: 'Cabbage', isFolder: false, addID: 8);
      newToDoList.addItem(name: 'Celery', isFolder: false, addID: 8);

      newToDoList.addItem(name: 'Recipes', isFolder: true, addID: 0);
      newToDoList.addItem(name: 'Lasagna', isFolder: true, addID: 13);
      newToDoList.addItem(name: 'Tomatoes', isFolder: false, addID: 14);
      newToDoList.addItem(name: 'Lasagne', isFolder: false, addID: 14);
      newToDoList.addItem(name: 'Spices', isFolder: false, addID: 14);
    } else if (name == 'Schoolwork') {
      newToDoList.addItem(name: 'Projects', isFolder: true, addID: 0);
      newToDoList.addItem(name: 'SE-I', isFolder: true, addID: 1);
      newToDoList.addItem(name: 'Design', isFolder: false, addID: 2);
      newToDoList.addItem(name: 'UML', isFolder: false, addID: 2);
      newToDoList.addItem(name: 'Code', isFolder: false, addID: 2);

      newToDoList.addItem(name: 'MAP', isFolder: true, addID: 0);
      newToDoList.addItem(name: 'Creative 2', isFolder: true, addID: 6);
      newToDoList.addItem(name: 'Design', isFolder: false, addID: 7);
      newToDoList.addItem(name: 'Code', isFolder: false, addID: 7);
      newToDoList.addItem(name: 'Record', isFolder: false, addID: 7);
    } else {
      newToDoList.addItem(name: 'Sweep', isFolder: false, addID: 0);
      newToDoList.addItem(name: 'Dust', isFolder: false, addID: 0);
      newToDoList.addItem(name: 'Vaccuum', isFolder: false, addID: 0);
      newToDoList.addItem(name: 'Trash', isFolder: false, addID: 0);
    }

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
