import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';
import 'package:to_do_list/layout/custom_appbar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(),
      body: Placeholder(),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: selectedBottomNavIndexNotifier,
        builder: (context, bottomNavIndex, child) {
          return BottomNavigationBar(
            currentIndex: bottomNavIndex,
            onTap: (newIndex) {
              selectedBottomNavIndexNotifier.value = newIndex;
            },
            backgroundColor: theme.colorScheme.onPrimary,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: theme.colorScheme.primary,
                ),
                activeIcon: Icon(Icons.home, color: theme.colorScheme.primary),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.favorite,
                  color: theme.colorScheme.primary,
                ),
                icon: Icon(
                  Icons.favorite_border,
                  color: theme.colorScheme.primary,
                ),
                label: 'Favorites',
              ),
            ],
          );
        },
      ),
    );
  }
}
