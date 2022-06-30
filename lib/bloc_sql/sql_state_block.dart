import 'package:calendar_block_test_task/models/task_sql.dart';

abstract class SQLState {}

class UserSQLEmptyState extends SQLState {}

//the state is responsible for submitting our jobs to the UI
class UserLoadTasksState extends SQLState {
  List<Task> loadedList;
  UserLoadTasksState({
    required this.loadedList,
  });
}

class UserSQLErrorState extends SQLState {}
