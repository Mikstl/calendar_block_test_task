//Creating an abstract class responsible for getting the state of the application after processing by the business logic.
import 'package:calendar_block_test_task/models/calendar.dart';

abstract class UserState {}

class UserEmptyState extends UserState {}

//The state responsible for the return of our calendar in the UI
class UserLoadCalendarState extends UserState {
  List<Calendar> loadedCalendarList;
  DateTime currentDateTime;
  DateTime selectedDateTime;
  UserLoadCalendarState(
      {required this.loadedCalendarList,
      required this.currentDateTime,
      required this.selectedDateTime});
}

class UserErrorState extends UserState {}
