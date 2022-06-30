import 'package:calendar_block_test_task/bloc_calendar/event_block.dart';
import 'package:calendar_block_test_task/services/calendar_functions.dart';
import 'package:calendar_block_test_task/services/sql_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_calendar/bloc.dart';
import '../widgets/calendar_body.dart';

class CalendarPage extends StatelessWidget {
  final CalendarFunctions calendarFunctions = CalendarFunctions();
  final FunctionsSQL db = FunctionsSQL();

  CalendarPage({Key? key}) : super(key: key);
  //The page is responsible for displaying our calendar
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      //Associating our block with the repository
      create: (context) =>
          //Add the calendar load event on page initialization
          UserBloc(calendarFunctions, db)..add(UserLoadCalendar()),
      child: const Scaffold(
          body: Center(
        child: CalendarBody(),
      )),
    );
  }
}
