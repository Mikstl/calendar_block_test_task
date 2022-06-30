import 'package:calendar_block_test_task/models/task_sql.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DataBaseProvider {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDataBase();
    return _database;
  }

  Future<Database> _initDataBase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = ('${dir.path}/tasks.db');
    return await openDatabase(path, version: 1, onCreate: _createDataBase);
  }

  void _createDataBase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, finishTime TEXT, description TEXT)');
  }

  Future<List<Task>> getTasks() async {
    // Get a reference to the database.

    final db = await database;

    // Query the table for all The tasks.
    final List<Map<String, dynamic>> maps = await db!.query('tasks');

    final List<Task> listTask = List.generate(maps.length, (i) {
      return Task(
        date: maps[i]['date'],
        finishTime: maps[i]['finishTime'],
        description: maps[i]['description'],
      );
    });
    // print(listTask);
    return listTask;
  }

  Future<List<Task>> getTasksfromDate(String date) async {
    // Get a reference to the database.
    final db = await database;
    // Query the table for all The tasks.
    final List<Map<String, dynamic>> maps =
        await db!.rawQuery('SELECT * FROM tasks WHERE date=?', [date]);
    final List<Task> listTask = List.generate(maps.length, (i) {
      return Task(
        date: maps[i]['date'],
        finishTime: maps[i]['finishTime'],
        description: maps[i]['description'],
      );
    });

    return listTask;
  }

  Future<void> insertTask(Task task) async {
    Database? db = await database;
    await db!.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteTask(String description) async {
    Database? db = await database;

    return await db!
        .rawDelete('DELETE FROM tasks WHERE description=?', [description]);
  }
}
