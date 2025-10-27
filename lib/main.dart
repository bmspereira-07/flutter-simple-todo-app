import 'package:flutter/material.dart';
import 'package:to_do_list/data/notifiers.dart';
import 'package:to_do_list/pages/favorites_page.dart';
import 'package:to_do_list/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Widget> pages = [const MyHomePage(), const FavoritesPage()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedBottomNavIndexNotifier,
      builder: (context, selectedBotNavIndex, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo-it',
          theme: ThemeData(
            useMaterial3: true,
            iconTheme: const IconThemeData(color: Colors.white, size: 28.0),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,

              primary: Colors.teal,
              brightness: Brightness.light,
            ),
          ),
          home: pages[selectedBotNavIndex],
        );
      },
    );
  }
}
