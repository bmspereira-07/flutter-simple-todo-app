import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: todoListsNotifier,
      builder: (context, value, child) {
        var hasFavorites = todoListsNotifier.value.any(
          (list) => list.isFavorite == true,
        );

        return BottomNavigationBar(
          currentIndex: selectedBottomNavIndexNotifier.value,
          onTap: (newIndex) {
            selectedBottomNavIndexNotifier.value = newIndex;
          },
          backgroundColor: theme.colorScheme.onPrimary,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: theme.colorScheme.primary),
              activeIcon: Icon(Icons.home, color: theme.colorScheme.primary),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Badge(
                isLabelVisible: hasFavorites,
                offset: const Offset(12.0, 10.0),
                label: hasFavorites
                    ? Text(
                        todoListsNotifier.value
                            .where((list) => list.isFavorite)
                            .length
                            .toString(),
                      )
                    : null,
                backgroundColor: theme.colorScheme.primary,
                child: Icon(Icons.favorite, color: theme.colorScheme.primary),
              ),
              icon: Badge(
                offset: const Offset(12.0, 10.0),
                isLabelVisible: hasFavorites,
                label: Text(
                  todoListsNotifier.value
                      .where((list) => list.isFavorite)
                      .length
                      .toString(),
                ),
                backgroundColor: theme.colorScheme.primary,
                child: Icon(
                  Icons.favorite_border,
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'Favorites',
            ),
          ],
        );
      },
    );
  }
}
