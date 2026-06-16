import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/constants/app_constants.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);
    return openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _createDb,
    );
  }

  static Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.favoritesTable} (
        id        TEXT PRIMARY KEY,
        name      TEXT NOT NULL,
        thumbnail TEXT NOT NULL
      )
    ''');
  }

  static Future<void> resetForTest() async {
    _database = null;
  }
}
