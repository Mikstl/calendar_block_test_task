//Creating an abstract class from which all events transmitted to the business logic are inherited (block)
abstract class UserEvent {}

// event when upload all tasks
class UserLoadCalendar extends UserEvent {}

// event when upload work tasks
class UserChangeMonthNext extends UserEvent {}

// event when upload home tasks
class UserChangeMonthPrev extends UserEvent {}
