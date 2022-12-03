// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_unnecessary_containers, annotate_overrides, must_be_immutable, avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';
import '../db/notfication_helper.dart';
import '../screens/todo.dart';
import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import '../ui/widget/fun.dart';
import 'note.dart';
import 'report.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ToDoController controller = Get.find<ToDoController>();
  final notify = NotificationHelper();
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    notify.initializeNotification();
    notify.requestIOSPermissions();
  }

  Widget bottomNav(String img, int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _pageIndex = index;
        });
      },
      child: AnimatedContainer(
        height: 50.0,
        decoration: BoxDecoration(
          color: index == _pageIndex
              ? prColor.withOpacity(0.8)
              : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInToLinear,
        child: Card(
          elevation: index == _pageIndex ? 10.0 : 0.0,
          color: Colors.transparent,
          margin: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(img, width: 35, height: 40),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _pageIndex == index ? 1.0 : 0.0,
                  child: My_Text(
                    size: 14,
                    data: _pageIndex == index ? label : '',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const NotePage(),
      const TodoScreen(),
      const ReportScreen(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Card(
        elevation: 10,
        shadowColor: prColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(bottom: 3, left: 8, right: 7),
        child: Container(
          decoration: BoxDecoration(
            color: Fun.checkTheme() ? grColor : prColor.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(child: bottomNav('assets/images/n1.png', 0, 'المفكرة')),
              Expanded(child: bottomNav('assets/images/n2.png', 1, 'المهام')),
              Expanded(child: bottomNav('assets/images/n3.png', 2, 'التقارير')),
            ],
          ),
        ),
      ),
      backgroundColor: Fun.checkTheme() ? blColor : null,
      appBar: appBar(),
      body: pages[_pageIndex],
    );
  }

  appBar() {
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
                  notify.displayNotification(
                      title: '🌴 تم تغيير الوضع',
                      body: '  تم تغيير الوضع بنجاح  !   😍🌴💐');

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
}
