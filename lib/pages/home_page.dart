import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';
import 'package:to_do_list/layout/custom_appbar.dart';
import 'package:to_do_list/models/list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    _fillToDoLists();

    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorScheme.onPrimary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: theme.colorScheme.primary),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: theme.colorScheme.primary),
            icon: Icon(Icons.favorite_border, color: theme.colorScheme.primary),
            label: 'Favorites',
          ),
        ],
      ),
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
                      return ListView.builder(
                        itemCount: toDoLists.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ListTile(
                              tileColor: theme.colorScheme.primary,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 1.0,
                                ),
                              ),
                              title: Text(toDoLists[index].name),
                              leading: IconButton(
                                onPressed: () {
                                  toDoLists[index].toggleFavorite();
                                  // ValueNotifier won't detect mutations inside the
                                  // list automatically, so assign a new list
                                  // reference to trigger the notifier
                                  todoListsNotifier.value = List<TodoList>.from(
                                    toDoLists,
                                  );
                                },
                                icon: Icon(
                                  toDoLists[index].isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  toDoLists.removeAt(index);
                                  todoListsNotifier.value = List<TodoList>.from(
                                    toDoLists,
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          );
                        },
                      );
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

  void _fillToDoLists() {
    if (todoListsNotifier.value.isEmpty) {
      todoListsNotifier.value = [
        TodoList(name: 'Personal'),
        TodoList(name: 'Work'),
        TodoList(name: 'Shopping'),
      ];
    }
  }
}
