import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';
import 'package:to_do_list/layout/custom_appbar.dart';
import 'package:to_do_list/layout/custom_bottom_nav.dart';
import 'package:to_do_list/models/list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: todoListsNotifier,
                  builder: (context, toDoLists, child) {
                    return Text(
                      'My lists (${toDoLists.length})',
                      style: theme.textTheme.titleLarge,
                    );
                  },
                ),
              ],
            ),
            Divider(color: theme.colorScheme.primary),

            // List of TodoLists
            Expanded(
              child: SafeArea(
                child: Material(
                  type: MaterialType.transparency,
                  borderOnForeground: false,
                  child: ValueListenableBuilder(
                    valueListenable: todoListsNotifier,
                    builder: (context, toDoLists, child) {
                      return ToDoListViewer(theme: theme, list: toDoLists);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToDoListViewer extends StatelessWidget {
  const ToDoListViewer({super.key, required this.theme, required this.list});

  final ThemeData theme;

  final List<TodoList> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            tileColor: theme.colorScheme.primary,
            textColor: Colors.white,
            iconColor: Colors.white,
            titleTextStyle: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: theme.colorScheme.primary, width: 1.0),
            ),
            title: Text(list[index].name),
            leading: IconButton(
              onPressed: () {
                list[index].toggleFavorite();
                // ValueNotifier won't detect mutations inside the
                // list automatically, so assign a new list
                // reference to trigger the notifier
                todoListsNotifier.value = List<TodoList>.from(list);
              },
              icon: Icon(
                list[index].isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                list.removeAt(index);
                todoListsNotifier.value = List<TodoList>.from(list);
              },
              icon: Icon(Icons.delete_outline),
            ),
          ),
        );
      },
    );
  }
}
