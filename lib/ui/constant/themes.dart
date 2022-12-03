// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

const Color newColor = Color(0xff1B95AF);
const Color prColor = Color.fromARGB(-38, 0, 151, 136);
const Color scColor = Color.fromARGB(255, 58, 186, 246);
const Color grColor = Color.fromARGB(255, 127, 116, 116);
const Color ylColor = Color.fromARGB(255, 255, 213, 60);
const Color blColor = Colors.black;
const Color biColor = Color.fromARGB(255, 213, 59, 230);
const Color reColor = Color.fromARGB(255, 255, 79, 176);
const Color pr2Color = Color.fromARGB(-25, 199, 253, 191);

//! images
const String KPICSPLASH = 'assets/images/note2.json';
const String KPICN1 = 'assets/images/n1.png';
const String KPICN2 = 'assets/images/n2.png';
const String KPICN3 = 'assets/images/n3.png';
const String Kh1 = 'assets/images/kh1.jpg';

class my_themes {
  static final dk = ThemeData(
      scaffoldBackgroundColor: blColor,
      timePickerTheme: const TimePickerThemeData(backgroundColor: prColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Molhim',
      useMaterial3: true,
      // floatingActionButtonTheme:
      //     const FloatingActionButtonThemeData(backgroundColor: Colors.teal),
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      backgroundColor: blColor);

  static final lt = ThemeData(
    fontFamily: 'Molhim',
    useMaterial3: true,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.teal),
    appBarTheme: const AppBarTheme(
      backgroundColor: prColor,
    ),
    brightness: Brightness.light,
    primaryColor: prColor,
  );
}

TextStyle get inPutStyle {
  return const TextStyle(
    fontFamily: 'Molhim',
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get subheading {
  return const TextStyle(
    fontFamily: 'Molhim',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get headingStyle {
  return const TextStyle(
    fontSize: 25,
    fontFamily: 'Molhim',
    fontWeight: FontWeight.bold,
  );
}

final box = GetStorage();
