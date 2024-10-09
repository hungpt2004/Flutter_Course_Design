import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:todolist_app_flutter/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
        id: 1,
        name: 'Buy milk',
        description: 'With my friends study at the university',
        createdAt: DateTime.now(),
        deadlineAt: DateTime(2024, 10, 9, 1, 0)), // Current date and time
    Task(
        id: 2,
        name: 'Buy eggs',
        description: 'With my friends study at the university',
        createdAt: DateTime(2024, 10, 7, 8, 0),
        deadlineAt: DateTime(2024, 10, 9, 1, 0)), // Specific date and time
    Task(
        id: 3,
        name: 'Buy bread',
        description: 'With my friends study at the university',
        createdAt: DateTime(2024, 10, 8, 9, 30),
        deadlineAt:
            DateTime(2024, 10, 9, 1, 0)), // Another specific date and time
  ];


  int _nextItemsId = 4;

  //Getter for List<Tasks>
  List<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle, String newDescription, DateTime newTaskCreatedAt, DateTime newDeadlineAt) {
    final task = Task(
        id: _nextItemsId,
        name: newTaskTitle,
        description: newDescription,
        createdAt: newTaskCreatedAt,
        deadlineAt: newDeadlineAt);
    _tasks.add(task);
    _nextItemsId++;
    notifyListeners();
  }

  void updateTask(String name, String description, DateTime deadline, int id){
    Task? task = findById(id);
    if(task != null) {
      task.name = name;
      task.description = description;
      task.deadlineAt = deadline;
    }
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  var _showFavoritesOnly = false;

  List<Task> get items {
    if (_showFavoritesOnly) {
      return _tasks.where((prodItem) => prodItem.isFavourite).toList();
    }
    return [..._tasks];
  }

  List<Task> get favoriteItems {
    return _tasks.where((prodItem) => prodItem.isFavourite).toList();
  }

  Task? findById(int id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  void removeByID(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
  }

  void showAll() {
    _showFavoritesOnly = false;
  }
}
