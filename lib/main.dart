import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/editTask.dart';
import 'package:flutter_application_1/service/tasklist.dart';
import 'package:provider/provider.dart';

import 'page/addtask.dart';
import 'page/listpage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Tasklist>(
          create: (context) => Tasklist(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const MyListPage(),
        "/addTask": (context) => const AddTaskPage(),
        "/editTask": (context) => const EditTaskPage(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
