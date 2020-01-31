import 'package:flutter/material.dart';
import 'package:sqflite_demo/services/handle_db.dart';

class Result extends StatefulWidget {
  final String title;
  final int index;
  Result({this.title, this.index});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String _body;

  void getBody() async {
    List<Map> list = await DataBaseHandler().getBody(widget.index);
    _body = list[0]['body'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text(
            _body,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
