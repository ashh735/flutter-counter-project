import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> initDB() async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'subject_data.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE subjects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            subjectName TEXT,
            course TEXT,
            marks INTEGER,
            creditHour REAL,
            semester INTEGER
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<int> insertData(Map<String, dynamic> data) async {
    final db = await initDB();
    return await db.insert('subjects', data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await initDB();
    return await db.query('subjects');
  }
}
