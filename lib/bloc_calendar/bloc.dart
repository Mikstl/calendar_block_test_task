import 'package:calendar_block_test_task/bloc_calendar/event_block.dart';
import 'package:calendar_block_test_task/bloc_calendar/state_block.dart';
import 'package:calendar_block_test_task/models/task_sql.dart';
import 'package:calendar_block_test_task/services/calendar_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/calendar.dart';
import '../services/sql_functions.dart';

//This file is responsible for the business logic of the calendar, depending on the incoming event.

class UserBloc extends Bloc<UserEvent, UserState> {
  //Initialization of functions for working with the calendar
  CalendarFunctions calendarFunctions;
  //Initialization of functions for working with the database
  FunctionsSQL db;

  UserBloc(this.calendarFunctions, this.db) : super(UserEmptyState()) {
    on<UserLoadCalendar>((event, emit) async {
      try {
        //Get a list of dates for the selected month
        calendarFunctions.getCalendar();
        List<Calendar> loadedCalendarList = calendarFunctions.getCalendarList;

        //Request for tasks that are available this month
        List<Task> getTasksList = await db.getTasks();

        //Function counting how many tasks in a certain day
        loadedCalendarList = foundTaskforCalendar(
            getTasksList: getTasksList, loadedCalendarList: loadedCalendarList);

        //Sending status with received month and tasks
        emit(UserLoadCalendarState(
            loadedCalendarList: loadedCalendarList,
            currentDateTime: calendarFunctions.getCurrentDateTime,
            selectedDateTime: calendarFunctions.getSelectDateTime));
      } catch (_) {
        emit(UserErrorState());
      }
    });

    on<UserChangeMonthNext>((event, emit) async {
      try {
        calendarFunctions.getNextMonth();
        List<Calendar> loadedCalendarList = calendarFunctions.getCalendarList;

        List<Task> getTasksList = await db.getTasks();

        loadedCalendarList = foundTaskforCalendar(
            getTasksList: getTasksList, loadedCalendarList: loadedCalendarList);

        //Sending status with received month and tasks
        emit(UserLoadCalendarState(
            loadedCalendarList: loadedCalendarList,
            currentDateTime: calendarFunctions.getCurrentDateTime,
            selectedDateTime: calendarFunctions.getSelectDateTime));
      } catch (_) {
        emit(UserErrorState());
      }
    });

    on<UserChangeMonthPrev>((event, emit) async {
      try {
        calendarFunctions.getPrevMonth();
        List<Calendar> loadedCalendarList = calendarFunctions.getCalendarList;

        List<Task> getTasksList = await db.getTasks();

        loadedCalendarList = foundTaskforCalendar(
            getTasksList: getTasksList, loadedCalendarList: loadedCalendarList);

        emit(UserLoadCalendarState(
            loadedCalendarList: loadedCalendarList,
            currentDateTime: calendarFunctions.getCurrentDateTime,
            selectedDateTime: calendarFunctions.getSelectDateTime));
      } catch (_) {
        emit(UserErrorState());
      }
    });
  }

  //The function compares the values of the two received lists with the data
  // for finding tasks per day, and writes them to the calendar for the day
  List<Calendar> foundTaskforCalendar({loadedCalendarList, getTasksList}) {
    for (int i = 0; i < loadedCalendarList.length; i++) {
      String formattedeDate = DateFormat('dd/MM/yyyy')
          .format(loadedCalendarList[i].date)
          .toString();
      for (int j = 0; j < getTasksList.length; j++) {
        if (formattedeDate == getTasksList[j].date) {
          loadedCalendarList[i].amountTask++;
        }
      }
    }
    return loadedCalendarList;
  }
}
