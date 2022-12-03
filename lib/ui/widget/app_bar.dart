import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/todo_controller.dart';
import '../constant/themes.dart';

appBar() {
  final ToDoController controller = Get.put(ToDoController());
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: controller.loadThemeBox() ? blColor : null,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () {
            return IconButton(
              onPressed: () {
                controller.switchTheme();
              },
              icon: Icon(
                controller.loadThemeBox() ? Icons.sunny : Icons.mode_night,
              ),
            );
          },
        ),
      )
    ],
    title: SizedBox(
      height: 50,
      child: Image.asset(
        'assets/images/3.PNG',
        fit: BoxFit.fill,
      ),
    ),
  );
}
