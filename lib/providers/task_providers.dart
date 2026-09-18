import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/task.dart';

enum Filter { all, completed, notCompleted }

class TaskProviders extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(id: "1", title: "المهمة الأولى"),
    Task(id: "2", title: "المهمة الثانية"),
    Task(id: "3", title: "المهمة الثالثة"),
  ];
  final List<Task> _trash = [];

  Filter _filter = Filter.all;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  List<Task> get trash => _trash;

  List<Task> get tasks {
    if (_filter == Filter.completed) {
      return _tasks.where((task) => task.completed).toList();
    } else if (_filter == Filter.notCompleted) {
      return _tasks.where((task) => !task.completed).toList();
    }
    return _tasks;
  }

  void changeFilter(Filter newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    saveTheme();
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task, String title, String description) {
    task.title = title;
    task.description = description;
    saveTasks();
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.completed = !task.completed;
    saveTasks();
    notifyListeners();
  }

  // الحذف ينقل المهمة إلى سلة المحذوفات
  void removeTask(Task task) {
    _tasks.remove(task);
    _trash.add(task);
    saveTasks();
    notifyListeners();
  }

  void clearAllTasks() {
    _trash.addAll(_tasks);
    _tasks.clear();
    saveTasks();
    notifyListeners();
  }

  void restoreTask(Task task) {
    _trash.remove(task);
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void restoreAll() {
    _tasks.addAll(_trash);
    _trash.clear();
    saveTasks();
    notifyListeners();
  }

  void deleteForever(Task task) {
    _trash.remove(task);
    saveTasks();
    notifyListeners();
  }

  void emptyTrash() {
    _trash.clear();
    saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _encode(_tasks));
    await prefs.setStringList('trash', _encode(_trash));
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkMode = prefs.getBool('isDarkMode') ?? false;

    final tasksJson = prefs.getStringList('tasks');
    if (tasksJson != null) {
      _tasks.clear();
      _tasks.addAll(_decode(tasksJson));
    }

    final trashJson = prefs.getStringList('trash');
    if (trashJson != null) {
      _trash.clear();
      _trash.addAll(_decode(trashJson));
    }

    notifyListeners();
  }

  List<String> _encode(List<Task> list) =>
      list.map((task) => jsonEncode(task.toJson())).toList();

  List<Task> _decode(List<String> list) =>
      list.map((task) => Task.fromJson(jsonDecode(task))).toList();
}
