import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class TodoList with ChangeNotifier {
  String name;
  List<Task>? tasks;
  bool isFavorite;

  TodoList({required this.name, this.tasks, this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
