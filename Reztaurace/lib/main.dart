import 'package:flutter/material.dart';
import 'package:reztaurace/tabs/tab_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, //Vypnuti debug banneru, pri vytvoreni apk bude automaticky false
      title: "Reztaurace",
      home: TabManager(),
    );
  }
  }
