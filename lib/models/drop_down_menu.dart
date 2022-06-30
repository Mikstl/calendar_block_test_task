import 'package:flutter/material.dart';

//Model giving a list of our time

class DropDownMenuItems {
  final List<DropdownMenuItem<String>> menuItems = [];

  DropDownMenuItems() {
    int j = 0;
    int k = 0;
    int l = 0;
    int y = 0;
    int am = 1;
    int pm = 2;

    for (var i = 0; i < 24; i++) {
      if (i <= 9) {
        menuItems.add(DropdownMenuItem(
            value: "0${i.toString()}:00", child: Text("0${i.toString()}:00")));
      }
      if (i >= 10 && i <= 19) {
        menuItems.add(DropdownMenuItem(
            value: "${am.toString()},${j.toString()}:00",
            child: Text("${am.toString()}${j.toString()}:00")));
        j++;
      }
      if (i >= 19) {
        menuItems.add(DropdownMenuItem(
            value: "${pm.toString()},${k.toString()}:00",
            child: Text("${pm.toString()}${k.toString()}:00")));
        k++;
      }

      if (i != 23) {
        if (i <= 9) {
          menuItems.add(DropdownMenuItem(
              value: "0${i.toString()}:30",
              child: Text("0${i.toString()}:30")));
        }
        if (i >= 10 && i <= 19) {
          menuItems.add(DropdownMenuItem(
              value: "${am.toString()},${l.toString()}:30",
              child: Text("${am.toString()}${l.toString()}:30")));
          l++;
        }
        if (i >= 19) {
          menuItems.add(DropdownMenuItem(
              value: "${pm.toString()},${y.toString()}:30",
              child: Text("${pm.toString()}${y.toString()}:30")));
          y++;
        }
      }
    }
  }

  List<DropdownMenuItem<String>> get getItems {
    return menuItems;
  }
}
