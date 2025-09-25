import 'package:challenges/challenges/drag_drop.dart';
import 'package:challenges/challenges/loading_dots.dart';
import 'package:challenges/challenges/task_list.dart';
import 'package:challenges/home_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 2 Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/challenge1': (context) => const TaskList(),
        '/challenge2': (context) => const DragDrop(),
        '/challenge3': (context) => const LoadingDots(),
      },
    );
  }
}

