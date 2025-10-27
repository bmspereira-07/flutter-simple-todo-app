import 'package:flutter/material.dart';
import 'package:to_do_list/models/list.dart';

// ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

ValueNotifier<List<TodoList>> todoListsNotifier = ValueNotifier<List<TodoList>>(
  [],
);

ValueNotifier<int> selectedBottomNavIndexNotifier = ValueNotifier<int>(0);

void resetTodoLists() {
  todoListsNotifier.value = [];
}

void fillDefaultTodoLists() {
  if (todoListsNotifier.value.isEmpty) {
    todoListsNotifier.value = [
      TodoList(name: 'Personal'),
      TodoList(name: 'Work', isFavorite: true),
      TodoList(name: 'Shopping'),
    ];
  }
}
