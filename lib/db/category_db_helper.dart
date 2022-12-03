import 'package:flutter/foundation.dart' as foundation;
import 'package:sqflite/sqflite.dart';

import '../model/cat_model.dart';

class CategoryDbHelper {
  static final CategoryDbHelper instance = CategoryDbHelper._();
  static Database? _database;
  CategoryDbHelper._();
  final categoryTable = 'category';
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('$categoryTable.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    var dir = await getDatabasesPath();
    var path = dir + filePath;
    var database = openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          '''
          create table $categoryTable(
        id INTEGER primary key AUTOINCREMENT,
          name text not null,
          color integer not null
          )
          ''');
    });
    return database;
  }

  void insertCategory(CategoryModel category) async {
    var db = await database;
    var result = await db.insert(categoryTable, category.toMap());
    if (foundation.kDebugMode) {
      print("Insert Category: $result");
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    var db = await database;
    var queries = await db.query(categoryTable);
    if (foundation.kDebugMode) {
      print("Get All Categories : $queries");
    }
    List<CategoryModel> categories = [];
    for (var query in queries) {
      categories.add(CategoryModel.fromMap(query));
    }
    return categories;
  }
}
