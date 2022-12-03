// ignore_for_file: camel_case_types

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum REPEAT_TYPES { once, daily, monthly, weekdays, weekends }

class Fun {
  static final color = Random();
  static int colors = 0xff000000;
  static Color recolor() {
    return Color(color.nextInt(colors));
  }

  static String formatDate(DateTime date) {
    DateFormat dateFormat = DateFormat.yMMMEd();
    String formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  static String formatTime(DateTime time) {
    final format = DateFormat('hh :mm a');
    String formattedTime = format.format(time);
    return formattedTime;
  }

  static DateTime getTime(String time) {
    final format = DateFormat('hh :mm a');
    DateTime formattedTime = format.parseStrict(time);
    return formattedTime;
  }

  static bool checkTheme() {
    return Get.isDarkMode ? true : false;
  }

  static String getRepeatTypes(REPEAT_TYPES repeatType) {
    switch (repeatType) {
      case REPEAT_TYPES.once:
        return "بدون تكرار";
      case REPEAT_TYPES.daily:
        return "يومي";
      case REPEAT_TYPES.monthly:
        return "شهري";
      case REPEAT_TYPES.weekdays:
        return "أسبوعي";
      case REPEAT_TYPES.weekends:
        return "أجازة";
      default:
        break;
    }
    return '';
  }
}
