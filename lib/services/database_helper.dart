import 'package:flutter_do/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = 'todo.db';
  static const _databaseVersion = 1;

  //define table and column
  static const tableTodo = 'todoTable';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnSubtitle = 'subtitle';
  static const columnBody = 'body';
  static const columnIsFinished = 'isFinished';

  //define private constructor
  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  static final DatabaseHelper _instance = DatabaseHelper._();

  //method to open database
  Future<Database> open() async {
    final databasePath = await getApplicationDocumentsDirectory();
    final path = join(databasePath.path, _databaseName);

    //open the database
    return openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      //create database table here
      await db.execute('''CREATE TABLE $tableTodo ('
            '$columnId INTEGER PRIMARY KEY,'
            '$columnTitle TEXT, '
            '$columnSubtitle TEXT,'
            '$columnBody TEXT,'
            '$columnIsFinished INTEGER)''');
    });
  }

  //add
  Future<void> addTodo(Todo todo) async {
    //open the database
    final Database db = await open();

    //insert todoObject inside db
    await db.insert(tableTodo, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //get the database
  Future<List<Todo>> getTodos() async {
    //open the database
    final Database db = await open();

    //query all rows from the tableTodo table
    final List<Map<String, dynamic>> maps = await db.query(tableTodo);

    //convert the list of map into list of todoObject
    return List.generate(maps.length, (index) {
      return Todo(
        id: maps[index][columnId],
        title: maps[index][columnTitle],
        subtitle: maps[index][columnSubtitle],
        body: maps[index][columnBody],
        isFinished: maps[index][columnIsFinished],
      );
    });
  }

  //update the todoObject
  Future<void> updateTodo(Todo todo) async {
    //open database
    final Database db = await open();

    //update the database
    await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  //delete
  Future<void> deleteTodo(int id) async {
    //open the database
    final Database db = await open();

    //delete the contact
    await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }
}
