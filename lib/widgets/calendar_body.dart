import 'package:calendar_block_test_task/bloc_calendar/bloc.dart';
import 'package:calendar_block_test_task/bloc_calendar/event_block.dart';
import 'package:calendar_block_test_task/bloc_calendar/state_block.dart';
import 'package:calendar_block_test_task/models/date_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/calendar.dart';

enum CalendarViews { dates, months, year }

class CalendarBody extends StatefulWidget {
  const CalendarBody({Key? key}) : super(key: key);

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  CalendarViews _currentView = CalendarViews.dates;
  final List<String> _monthNames = [
    'Січень',
    'Лютий',
    'Березень',
    'Квітень',
    'Травень',
    'Червень',
    'Липень',
    'Серпень',
    'Вересень',
    'Жовтень',
    'Листопад',
    'Грудень'
  ];

  @override
  Widget build(BuildContext context) {
    //Initializing our block to send events from this widget to our business logic
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    //Getting the width and height of our application window
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    //the size of our heading days of the week
    final sizeWeek = width * 0.13;
    int? midYear;

    //Initialization of the Bloc widget that converts the received state from the business logic to the UI
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserLoadCalendarState) {
          return Container(
              padding: EdgeInsets.only(top: height * 0.20),
              height: height,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: <Widget>[
                  // header
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    child: Row(
                      children: <Widget>[
                        // prev month button

                        _toggleBtn(false, midYear, state, userBloc),
                        //Display the selected current month
                        _topBarDate(state),

                        // next month button

                        _toggleBtn(true, midYear, state, userBloc),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // titles days for the calendar
                  _titlesCalendar(sizeWeek),
                  //Display сalendar body
                  _calendarBody(state, userBloc, width),
                ],
              ));
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: null,
        );
      },
    );
  }

  Widget _calendarBody(var state, UserBloc userBloc, var width) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: state.loadedCalendarList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, mainAxisSpacing: 5, mainAxisExtent: 43),
        itemBuilder: (context, index) {
          if (state.loadedCalendarList[index].date == state.selectedDateTime) {
            //Today date display
            return _selector(
                state.loadedCalendarList[index],
                state.loadedCalendarList[index].amountTask,
                width,
                state.selectedDateTime,
                userBloc);
          }
          //Days dates display
          return _calendarDates(
              state.loadedCalendarList[index],
              state.selectedDateTime,
              userBloc,
              state.loadedCalendarList[index].amountTask,
              width);
        },
      ),
    );
  }

  Widget _titlesCalendar(var sizeWeek) {
    return Container(
      padding: EdgeInsets.zero,
      height: 40.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "ПН",
              style: TextStyle(fontSize: 14, color: Color(0xff212121)),
            ),
          ),
        ),
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "ВТ",
              style: TextStyle(fontSize: 14, color: Color(0xff212121)),
            ),
          ),
        ),
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "СР",
              style: TextStyle(fontSize: 14, color: Color(0xff212121)),
            ),
          ),
        ),
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "ЧТ",
              style: TextStyle(fontSize: 14, color: Color(0xff212121)),
            ),
          ),
        ),
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "ПТ",
              style: TextStyle(fontSize: 14, color: Color(0xff212121)),
            ),
          ),
        ),
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "СБ",
              style: TextStyle(fontSize: 14, color: Color(0xff212121)),
            ),
          ),
        ),
        SizedBox(
          width: sizeWeek,
          child: const Center(
            child: Text(
              "НД",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xff212121)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _topBarDate(var state) {
    return // month and year
        Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentView = CalendarViews.months),
        child: Center(
          child: Text(
            '${_monthNames[state.currentDateTime.month - 1]} ${state.currentDateTime.year}',
            style: const TextStyle(
                color: Color(0xff1E1E1E),
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _toggleBtn(bool next, int? midYear, var state, UserBloc userBloc) {
    return InkWell(
      onTap: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next)
              ? userBloc.add(UserChangeMonthNext())
              : userBloc.add(UserChangeMonthPrev()));
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear = (midYear == null)
                ? state.currentDateTime.year + 9
                : midYear! + 9;
          } else {
            midYear = (midYear == null)
                ? state.currentDateTime.year - 9
                : midYear! - 9;
          }
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        child: Icon(
          (next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
          color: const Color(0xff1E1E1E),
        ),
      ),
    );
  }

  Widget _selector(Calendar calendarDate, int amountTask, var width,
      DateTime selectedDateTime, UserBloc userBloc) {
    return GestureDetector(
      onTap: () {
        DateTask date = DateTask(calendarDate.date);
        Navigator.pushNamed(context, '/task', arguments: date);
        // _returnDataFromSecondScreen(
        //     context: context, userBloc: userBloc, sendDateToNextRoute: date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          (amountTask == 0
              ? SizedBox(
                  height: width * 0.04,
                  width: width * 0.04,
                )
              : Container(
                  margin: const EdgeInsets.only(right: 2),
                  height: width * 0.04,
                  width: width * 0.04,
                  decoration: const BoxDecoration(
                    color: Color(0xffFF0266),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: (Text(amountTask.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ))),
                  ),
                )),
          Center(
            child: Text(
              '${calendarDate.date.day}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 0.9,
                  color: Color(0xff0336FF),
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  // calendar element
  Widget _calendarDates(Calendar calendarDate, DateTime selectedDateTime,
      UserBloc userBloc, int amountTask, var width) {
    return GestureDetector(
        onTap: () async {
          DateTask date = DateTask(calendarDate.date);
          await Navigator.pushNamed(context, '/task', arguments: date);
          setState(() {
            userBloc.add(UserLoadCalendar());
          });
          // _returnDataFromSecondScreen(
          //     context: context, userBloc: userBloc, sendDateToNextRoute: date);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: (amountTask == 0
                  ? SizedBox(
                      height: width * 0.04,
                      width: width * 0.04,
                    )
                  : Container(
                      margin: const EdgeInsets.only(right: 2),
                      height: width * 0.04,
                      width: width * 0.04,
                      decoration: const BoxDecoration(
                        color: Color(0xffFF0266),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(amountTask.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            )),
                      ),
                    )),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                width: width * 0.10,
                child: Center(
                  child: Text(
                    '${calendarDate.date.day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 0.9,
                      fontSize: 18,
                      color: (calendarDate.thisMonth)
                          ? (calendarDate.date.weekday == DateTime.sunday)
                              ? Colors.black
                              : Colors.black
                          : (calendarDate.date.weekday == DateTime.sunday)
                              ? const Color(0xff576F72).withOpacity(0.5)
                              : const Color(0xff576F72).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

//   void _returnDataFromSecondScreen({
//     required BuildContext context,
//     var userBloc,
//     required DateTask sendDateToNextRoute,
//   }) async {
//     await
//     setState(() {});
//     //Conditions that determine from which list of tasks editing was selected
//   }
}
