import 'package:flutter_do/services/database_helper.dart';

class Todo {
  int id;
  String title;
  String? subtitle;
  String body;
  bool isFinished;

  Todo({
    required this.id,
    required this.title,
    this.subtitle,
    required this.body,
    this.isFinished = false
});

  Map<String, dynamic> toMap(){
    return{
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnSubtitle: subtitle,
      DatabaseHelper.columnBody: body,
      DatabaseHelper.columnIsFinished: isFinished,
    };
  }
}