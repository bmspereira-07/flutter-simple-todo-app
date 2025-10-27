import 'package:flutter/material.dart';

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
      title: const Text('Todo-it'),
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: Colors.white,
    );
  }
}
