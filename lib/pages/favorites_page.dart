import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';
import 'package:to_do_list/layout/custom_appbar.dart';
import 'package:to_do_list/layout/custom_bottom_nav.dart';
import 'package:to_do_list/models/list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            children: [
              Text(
                'My favorite lists.',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
              Divider(color: theme.colorScheme.primary),
              SizedBox(height: 20),
              Flexible(child: FavoriteListViewer()),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteListViewer extends StatelessWidget {
  const FavoriteListViewer({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: todoListsNotifier,
      builder: (context, toDoLists, child) {
        var favoriteLists = toDoLists.where((list) => list.isFavorite).toList();
        if (favoriteLists.isEmpty) {
          return Center(
            child: Text(
              'No favorite lists yet.',
              style: theme.textTheme.bodyMedium,
            ),
          );
        } else {
          return _buildListView(favoriteLists, theme);
        }
      },
    );
  }

  ListView _buildListView(List<TodoList> favoriteLists, theme) {
    return ListView.builder(
      itemCount: favoriteLists.length,
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
            title: Text(favoriteLists[index].name),
            leading: IconButton(
              onPressed: () {
                favoriteLists[index].toggleFavorite();
                // ValueNotifier won't detect mutations inside the
                // list automatically, so assign a new list
                // reference to trigger the notifier
                todoListsNotifier.value = List<TodoList>.from(favoriteLists);
              },
              icon: Icon(
                favoriteLists[index].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                favoriteLists.removeAt(index);
                todoListsNotifier.value = List<TodoList>.from(favoriteLists);
              },
              icon: Icon(Icons.delete_outline),
            ),
          ),
        );
      },
    );
  }
}
