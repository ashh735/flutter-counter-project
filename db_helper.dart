import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mydb.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE texts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertText(String text) async {
    final db = await database;
    await db.insert('texts', {'content': text});
  }

  Future<List<Map<String, dynamic>>> getTexts() async {
    final db = await database;
    return await db.query('texts');
  }
}
