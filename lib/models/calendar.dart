//Model of our calendar

class Calendar {
  final DateTime date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;
  int amountTask;

  Calendar(
      {required this.date,
      this.amountTask = 0,
      this.thisMonth = false,
      this.prevMonth = false,
      this.nextMonth = false});
}
