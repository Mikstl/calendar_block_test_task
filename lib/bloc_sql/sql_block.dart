import 'package:calendar_block_test_task/bloc_sql/sql_event_block.dart';
import 'package:calendar_block_test_task/bloc_sql/sql_state_block.dart';
import 'package:calendar_block_test_task/models/task_sql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/sql_functions.dart';

//This business logic is designed to work with data in the application
class BlocSQL extends Bloc<SQLEvent, SQLState> {
  FunctionsSQL sqlFunctions;

  BlocSQL(this.sqlFunctions) : super(UserSQLEmptyState()) {
    on<UserLoadSQLTasks>((event, emit) async {
      try {
        final List<Task> listTask =
            await sqlFunctions.getTasksforDate(date: event.dateSelectedDay);
        emit(UserLoadTasksState(loadedList: listTask));
      } catch (_) {
        emit(UserSQLErrorState());
      }
    });

    on<UserCreateTask>((event, emit) async {
      try {
        sqlFunctions.createTask(
            date: event.dateSelectedDay,
            description: event.description,
            finishTime: event.finishTime);
      } catch (_) {
        emit(UserSQLErrorState());
      }
    });

    on<UserDeleteTask>((event, emit) async {
      try {
        sqlFunctions.deleteTask(description: event.description);
        final List<Task> listTask =
            await sqlFunctions.getTasksforDate(date: event.dateSelectedDay);
        emit(UserLoadTasksState(loadedList: listTask));
      } catch (_) {
        emit(UserSQLErrorState());
      }
    });
  }
}
