import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Drawer(backgroundColor: theme.primaryColor);
  }
}
