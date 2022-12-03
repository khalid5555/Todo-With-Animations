import '../model/todo_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ToDoDbHelper {
  static Database? _db;
  static const _version = 1;
  static const String _tabelname = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()} + tasks.db';
        _db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) {
            print('open todo');

            return db.execute(
              "CREATE TABLE $_tabelname ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title TEXT, todo TEXT,date STRING,"
              "remind TEXT,repeat TEXT,"
              "color INTEGER,"
              "isCompleted INTEGER NOT NULL )",
            );
          },
        );
      } catch (e) {
        Get.snackbar('wrong....', e.toString());
      }
    }
  }

  static Future<int> insertTask(TodoModel? task) async {
    return await _db?.insert(_tabelname, task!.toMap()) ?? 0;
  }

  static void updateTodo(TodoModel todo) async {
    await _db!.update(_tabelname, todo.toMap(),
        where: 'id=?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tabelname);
  }

  static delete(String id) async {
    return await _db!.delete(_tabelname, where: 'id=?', whereArgs: [id]);
  }

  static updateComplete(int id) async {
    return await _db!.rawUpdate(
        '''UPDATE tasks SET isCompleted = ?, WHERE id = ?,''', [1, id]);
  }
}
