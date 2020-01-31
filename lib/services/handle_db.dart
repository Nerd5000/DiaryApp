import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_demo/model/diary_mokeup.dart';

class DataBaseHandler {
  Database database;

  //create a database and create a table
  void createDatabase(String name) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, name);
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      //triggers when creating the database for the first time
      await db.execute('''CREATE TABLE diaries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject text,
        body text
      )
      ''');
    });
  }

  Future<List> getSubject() async {
    List<Map> list = await database.rawQuery('SELECT subject FROM diaries');
    return list;
  }

  Future<List> getBody(int index) async {
    List list = await database
        .rawQuery('SELECT body FROM diaries where id=?', [index + 1]);
    return list;
  }

  //insert new records to the table
  void insertRecord(Diary diary) async {
    await database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO diaries(subject, body) VALUES(?, ?)',
          [diary.title, diary.body]);
    });
  }

  //read from the table and return a list of records
  Future readRecords() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    return list;
  }

  //get number of records on the table
  Future<int> getCountOfRecords() async {
    int count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM Test'));
    return count;
  }

  //delete records from a table
  void deleteRecords(String subject) async {
    await database.rawDelete('DELETE FROM diaries WHERE subject = ?', [
      subject,
    ]);
  }

  //close the database to end connection
  void closeDatabase() async {
    await database.close();
  }
}
