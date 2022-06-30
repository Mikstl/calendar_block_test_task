import 'package:calendar_block_test_task/models/calendar.dart';

import 'package:calendar_block_test_task/services/calendar_service.dart';

class CalendarFunctions {
  final date = DateTime.now();
  late DateTime _currentDateTime;
  late DateTime _selectedDateTime;
  late List<Calendar> _sequentialDates;
  late int midYear;

  CalendarFunctions() {
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
  }

  // get next month calendar
  void getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    getCalendar();
  }

  // get previous month calendar
  void getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    getCalendar();
  }

  // get calendar for current month
  void getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  List<Calendar> get getCalendarList {
    return _sequentialDates;
  }

  DateTime get getCurrentDateTime {
    return _currentDateTime;
  }

  DateTime get getSelectDateTime {
    return _selectedDateTime;
  }
}
