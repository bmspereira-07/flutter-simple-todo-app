import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo-it',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.red,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[300],
        iconTheme: const IconThemeData(color: Colors.white, size: 28.0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: MyHomePage(),
    );
  }
}
