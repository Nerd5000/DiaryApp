import 'package:flutter/material.dart';
import 'package:sqflite_demo/services/handle_db.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataBaseHandler db;
  int _count;
  List<String> _subject;

  void getCount() async {
    _count = await db.getCountOfRecords();
    setState(() {});
  }

  void getSubject() async {
    _subject = await db.getSubject();
  }

  @override
  void initState() {
    super.initState();
    getCount();
    getSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sqflite Demo'),
      ),
      body: ListView.builder(
        itemCount: _count,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            trailing: Icon(Icons.arrow_forward),
            title: Text(_subject[index]),
            onTap: () {
              //go to page where to read data
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //go to page where you can add data
        },
      ),
    );
  }
}
