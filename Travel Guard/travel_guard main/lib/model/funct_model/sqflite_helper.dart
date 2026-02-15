import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = 'userProfile.db';
  static const _dbVersion = 1;
  static const _tableName = 'user';

  // Column names
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnLocation = 'location';
  static const columnPhone = 'phone';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // Create table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnEmail TEXT,
        $columnLocation TEXT,
        $columnPhone TEXT
      )
    ''');
  }

  // Insert a new user
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert(_tableName, user);
  }

  // Get user data
  Future<Map<String, dynamic>?> getUser() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);
    if (result.isEmpty) return null;
    return result.first;
  }

  // Update user data
  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    int id = user[columnId];
    return await db.update(
      _tableName,
      user,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete user data
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
