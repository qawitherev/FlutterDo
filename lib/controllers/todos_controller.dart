import 'package:flutter_do/models/todo.dart';
import 'package:flutter_do/services/database_helper.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  final _dbHelper = DatabaseHelper();

  Future<void> insertTodo(Todo todo) async {
    _dbHelper.addTodo(todo);
  }

  Future<List<Todo>> getTodos() async {
    return await _dbHelper.getTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await _dbHelper.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    await _dbHelper.deleteTodo(id);
  }
}