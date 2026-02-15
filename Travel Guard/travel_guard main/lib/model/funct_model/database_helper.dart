import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notifications (
            id TEXT PRIMARY KEY,
            customerName TEXT,
            reason TEXT,
            requestBy TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertNotification(Map<String, dynamic> notification) async {
    final db = await database;
    await db.insert(
      'notifications',
      notification,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final db = await database;
    return await db.query('notifications');
  }
}
