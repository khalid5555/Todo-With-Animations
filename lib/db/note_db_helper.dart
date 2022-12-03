import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '/model/note_model.dart';

class NoteDbHelper {
  // static final NoteDbHelper instance = NoteDbHelper._();

  static const _noteTable = 'noteTable';
  static Database? _db;
  static const _version = 1;

  // NoteDbHelper._();
// '$noteTable.db'
  // Future<Database> get database async {
  //   if (_db != null) return _db!;

  //   _db = await initDb();
  //   return _db!;
  // }

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String path = '${await getDatabasesPath()}+noteTable.db';
        _db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) {
            print('note open');
            db.execute(
                '''
          CREATE TABLE $_noteTable (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT,
           body TEXT,
           categoryId INTEGER ,
           color INTEGER ,
           dateTimeCreated TEXT,
           dateTimeEdited TEXT
          )        
        ''');
          },
        );
      } catch (e) {
        Get.snackbar('wrong....', e.toString());
      }
    }
  }

  static Future<int> insertNote(NoteModel note) async {
    return await _db!.insert(_noteTable, note.toMap());
  }

  static Future updateNote(NoteModel note) async {
    await _db!
        .update(_noteTable, note.toMap(), where: 'id=?', whereArgs: [note.id]);
    if (kDebugMode) {
      print("Update Note : ");
    }
  }

  static void deleteNote(String id) async {
    await _db!.delete(_noteTable, where: 'id=?', whereArgs: [id]);
    if (kDebugMode) {
      print("Delete Note : ");
    }
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    return await _db!.query(_noteTable);
  }

  static void search(String id) async {
    await _db!.query(_noteTable, where: 'id=?', whereArgs: [id]);
  }
}
