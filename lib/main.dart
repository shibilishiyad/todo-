import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/todomodel.dart';
import 'package:todo_app/screen%20/initial_screen.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/utils/screen_utils.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await TodoService().openBox(); // Open the box once using the singleton
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          ScreenUtil.init(context);
          return const InitialScreen();
        },
      ),
    );
  }
}