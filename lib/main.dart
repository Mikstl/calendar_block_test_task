import 'package:calendar_block_test_task/pages/calendar_page.dart';
import 'package:calendar_block_test_task/pages/date_task_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CalendarPage(),
      routes: {
        '/task': (context) => const DataTasksPage(),
        '/calendar': (context) => CalendarPage(),
      },
    );
  }
}
