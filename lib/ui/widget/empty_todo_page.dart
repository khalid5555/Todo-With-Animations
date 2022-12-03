// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/themes.dart';

class EmptyTodoPage extends StatelessWidget {
  bool isNote = false;
  EmptyTodoPage({
    Key? key,
    required this.isNote,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 9,
                child: Image.asset(
                  isNote ? 'assets/images/2.PNG' : 'assets/images/1.PNG',
                  height: 400,
                )),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                  text: isNote
                      ? 'لا يوجد مفكرة حتى الان'
                      : 'لا يوجد مهام لهذا اليوم ',
                  style: subheading.copyWith(color: prColor),
                  children: const <TextSpan>[
                    // TextSpan(text: '\nPlan up to', style: subheading),
                    // TextSpan(text: ' 50 days', style: subheading),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
