import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'flutter_sqflite_database.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE task(id INTEGER PRIMARY KEY, name TEXT, status INTEGER)',
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await _databaseService.database;

    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> taskList() async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('task');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<void> editTask(Task task, String before) async {
    try {
      final db = await _databaseService.database;
      int count = await db.update('task', task.toMap(),
          where: 'name = ?', whereArgs: [before]);
      print('count : ${count}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> deleteTask(Task task) async {
    final db = await _databaseService.database;
    return await db.delete('task', where: 'name = ?', whereArgs: [task.name]);
  }
}
