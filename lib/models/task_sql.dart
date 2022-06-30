//The model describes our task

class Task {
  late String date;
  late String finishTime;
  late String description;

  Task({
    required this.date,
    required this.finishTime,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'finishTime': finishTime,
      'description': description,
    };
  }

  // Task.fromMap(Map<String, dynamic> map) {
  //   date = map['date'];
  //   finishTime = map['finishtime'];
  //   description = map['description'];
  // }
}
