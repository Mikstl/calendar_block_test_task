import 'package:calendar_block_test_task/bloc_sql/sql_block.dart';
import 'package:calendar_block_test_task/models/date_task.dart';

import 'package:calendar_block_test_task/services/sql_functions.dart';
import 'package:calendar_block_test_task/widgets/date_task_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc_sql/sql_event_block.dart';

class DataTasksPage extends StatefulWidget {
  const DataTasksPage({Key? key}) : super(key: key);

  @override
  State<DataTasksPage> createState() => _DataTasksPageState();
}

//The page is responsible for showing the tasks recorded for the date we have chosen

//Initialization of functions for working with the database
final FunctionsSQL sqlFunctions = FunctionsSQL();

class _DataTasksPageState extends State<DataTasksPage> {
  @override
  Widget build(BuildContext context) {
    //Initialization of a variable responsible for storing application path settings and receiving data passed from another window
    RouteSettings settings = ModalRoute.of(context)!.settings;
    //Initialization of the class accepting our day selected by the user
    DateTask dateTask = settings.arguments as DateTask;
    //Date formatting for correct database lookup
    String formattedeDate =
        DateFormat('dd/MM/yyyy').format(dateTask.dateTask).toString();
    return BlocProvider<BlocSQL>(
        //Associating our block with the repository
        create: (context) =>
            BlocSQL(sqlFunctions)..add(UserLoadSQLTasks(formattedeDate)),
        child: const Scaffold(
          resizeToAvoidBottomInset: true,
          body: DataTasksPageBody(),
        ));
  }
}
