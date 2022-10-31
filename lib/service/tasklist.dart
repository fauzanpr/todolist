import 'package:flutter/material.dart';

import '../models/task.dart';
import 'database_service.dart';

class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<Task> _taskList = [];
  String _taskName = "";

  List<Task> get taskList => _taskList;
  String get taskName => _taskName;

  void changeTaskName(String taskName) {
    _taskName = taskName;
    notifyListeners();
  }

  Future<void> fetchTaskList() async {
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> addTask() async {
    await _databaseService.insertTask(
      Task(name: _taskName, status: 0),
    );
    notifyListeners();
  }

  Future<void> editTask(Task task, String before) async {
    // task.name = _taskName;
    await _databaseService.editTask(task, before);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await _databaseService.deleteTask(task);
    notifyListeners();
  }
}
