import 'package:flutter/material.dart';
import 'package:to_do_list/layout/custom_appbar.dart';
import 'package:to_do_list/layout/custom_bottom_nav.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Placeholder(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
