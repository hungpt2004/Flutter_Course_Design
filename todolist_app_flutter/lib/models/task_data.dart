import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:todolist_app_flutter/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk',description: 'With my friends study at the university', createdAt: DateTime.now()), // Current date and time
    Task(name: 'Buy eggs',description: 'With my friends study at the university', createdAt: DateTime(2024, 10, 7, 8, 0)), // Specific date and time
    Task(name: 'Buy bread',description: 'With my friends study at the university', createdAt: DateTime(2024, 10, 8, 9, 30)), // Another specific date and time
  ];

  List<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle,String newDescription, DateTime newTaskCreatedAt) {
    final task = Task(name: newTaskTitle,description: newDescription, createdAt: newTaskCreatedAt);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

}