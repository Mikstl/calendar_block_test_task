abstract class SQLEvent {}

// event when upload all tasks
class UserLoadSQLTasks extends SQLEvent {
  String dateSelectedDay;
  UserLoadSQLTasks(this.dateSelectedDay);
}

// event when create task
class UserCreateTask extends SQLEvent {
  String dateSelectedDay;
  String description;
  String finishTime;
  UserCreateTask(
      {required this.dateSelectedDay,
      required this.description,
      required this.finishTime});
}

// event when user want delete task
class UserDeleteTask extends SQLEvent {
  String description;
  String dateSelectedDay;
  UserDeleteTask({required this.description, required this.dateSelectedDay});
}
