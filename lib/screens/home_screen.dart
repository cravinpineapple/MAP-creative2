import 'package:creative2/model/UserRecord.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  UserRecord userRecord;
  _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(func) {
    setState(func);
  }

  @override
  Widget build(BuildContext context) {
    userRecord = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Welcome, ${userRecord.firstName} ${userRecord.lastName}'),
        backgroundColor: Colors.grey[600],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
        child: Column(
          children: [
            Container(
              width: 370.0,
              height: 75.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.grey[900],
                      width: 5.0,
                    )),
                color: Colors.grey[300],
                onPressed: () {},
                child: Text(
                  'YoYoYoYoYo',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _HomeScreenState state;

  _Controller(this.state);

  // List buildLists() {

  // }
}
