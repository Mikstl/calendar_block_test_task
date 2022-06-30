import 'package:calendar_block_test_task/models/task_sql.dart';
import 'package:calendar_block_test_task/services/sql_service.dart';

class FunctionsSQL {
  DataBaseProvider db = DataBaseProvider();

  void createTask(
      {required String date,
      required String description,
      required String finishTime}) {
    Task task =
        Task(date: date, description: description, finishTime: finishTime);
    db.insertTask(task);
  }

  Future<List<Task>> getTasks() async {
    return db.getTasks();
  }

  Future<List<Task>> getTasksforDate({required String date}) async {
    return db.getTasksfromDate(date);
  }

  void deleteTask({required String description}) {
    db.deleteTask(description);
  }
}
