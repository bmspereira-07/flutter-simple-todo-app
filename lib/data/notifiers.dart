import 'package:flutter/material.dart';
import 'package:to_do_list/models/list.dart';

// ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

ValueNotifier<List<TodoList>> todoListsNotifier = ValueNotifier<List<TodoList>>(
  [],
);
