import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';

class MyAppBar extends AppBar {
  MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      title: const Text('Todo-it'),
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: Colors.white,
      actions: [
        ValueListenableBuilder(
          valueListenable: todoListsNotifier,
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                resetTodoLists();
                fillDefaultTodoLists();
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: todoListsNotifier,
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                resetTodoLists();
              },
            );
          },
        ),
      ],
    );
  }
}
