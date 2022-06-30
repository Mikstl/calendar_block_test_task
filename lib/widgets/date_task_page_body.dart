import 'package:calendar_block_test_task/bloc_sql/sql_block.dart';
import 'package:calendar_block_test_task/bloc_sql/sql_event_block.dart';
import 'package:calendar_block_test_task/bloc_sql/sql_state_block.dart';
import 'package:calendar_block_test_task/models/date_task.dart';
import 'package:calendar_block_test_task/models/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DataTasksPageBody extends StatefulWidget {
  const DataTasksPageBody({Key? key}) : super(key: key);

  @override
  State<DataTasksPageBody> createState() => _DataTasksPageBodyState();
}

class _DataTasksPageBodyState extends State<DataTasksPageBody> {
  //Initializing the controller responsible for storing the state of our text
  final description = TextEditingController();

  //Initialization of the class responsible for the values of the drop-down list
  DropDownMenuItems dropDownItems = DropDownMenuItems();

  //default task completion time initialization
  String selectedValue = "00:00";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Initialization of a variable responsible for storing application path settings and receiving data passed from another window

    RouteSettings settings = ModalRoute.of(context)!.settings;

    //Initialization of the class accepting our day selected by the user

    DateTask dateTask = settings.arguments as DateTask;

    //Getting our list of time for tasks
    List<DropdownMenuItem<String>> menuItems = dropDownItems.getItems;

    //Date formatting for correct database lookup
    String dateforSQL =
        DateFormat('dd/MM/yyyy').format(dateTask.dateTask).toString();

    final BlocSQL blocSQL = BlocProvider.of<BlocSQL>(context);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Column(
      children: [
        SizedBox(
          height: height * 0.085,
        ),
        SizedBox(
          child: Text(
            dateforSQL,
            style: const TextStyle(
                fontSize: 24,
                color: Color(0xff383838),
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: _tasksBody(blocSQL, dateforSQL, width),
        ),
        _descriptionTaskBody(blocSQL, dateforSQL, width),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dropDownMenuBody(menuItems),
              _buttonCreateTaskBody(blocSQL, dateforSQL, width),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  //The widget is responsible for displaying tasks for the selected day
  Widget _tasksBody(BlocSQL blocSQL, String dateforSQL, var width) {
    return BlocBuilder<BlocSQL, SQLState>(builder: (context, state) {
      if (state is UserLoadTasksState) {
        return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.loadedList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    blocSQL.add(UserDeleteTask(
                        description: state.loadedList[index].description,
                        dateSelectedDay: dateforSQL));
                    state.loadedList.removeAt(index);

                    // items.removeAt(index);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(255, 231, 231, 231),
                        width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 3, bottom: 3),
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 12, bottom: 5),
                  child: SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(state.loadedList[index].description,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff383838))),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(state.loadedList[index].finishTime,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff383838))),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
      return Container();
    });
  }

  //The widget is responsible for the description field of the future task
  Widget _descriptionTaskBody(BlocSQL blocSQL, String dateforSQL, var width) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: description,
              style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff383838)),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 40, top: 40),
                hintText: 'Додати опис...',
                hintStyle: TextStyle(
                    fontSize: 21,
                    color: Color(0xff383838),
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(255, 19, 19, 19),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color.fromARGB(255, 19, 19, 19),
                  ),
                ),
              ),
              maxLines: 4,
            ),
          ],
        ));
  }

  //The widget is responsible for the dropdown list
  Widget _dropDownMenuBody(var menuItems) {
    return SizedBox(
      width: 120,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff0336FF), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff0336FF), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        value: selectedValue,
        items: menuItems,
        onChanged: (Object? value) {
          setState(() {
            selectedValue = value! as String;
          });
        },
      ),
    );
  }

  //The widget is responsible for the button and creating a new task
  Widget _buttonCreateTaskBody(BlocSQL blocSQL, String dateforSQL, var width) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
          minimumSize: MaterialStateProperty.all(const Size(200, 60)),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(253, 240, 38, 95))),
      onPressed: () {
        blocSQL.add(UserCreateTask(
            dateSelectedDay: dateforSQL,
            description: description.text,
            finishTime: selectedValue));
        Navigator.pushNamed(context, '/calendar');
      },
      child: const Text(
        "Створити",
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
