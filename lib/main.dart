import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.teal,
          secondary: Colors.grey.shade600,
          tertiary: Colors.black54,
          primaryContainer: Colors.teal.shade700,
        ),
        scaffoldBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Todo-it',
      home: const MyHomePage(),
    );
  }
}
