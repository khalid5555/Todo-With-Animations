// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/note_controller.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';
import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import '../ui/widget/fun.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ToDoController controller = Get.find();
  final NoteController noteController = Get.find();
  final TodoModel model = TodoModel();
  var isComplete = 0;

  Future<void> _launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'can\'t';
    }
  }

  void countIsComplete() {
    var ww = [];
    for (var element in controller.todolistfull) {
      if (element.isCompleted == 1) {
        ww.add(element);
        setState(() {
          isComplete = ww.length;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    countIsComplete();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reportTabs(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const My_Text(
                          data: 'أجمالي عدد المهام',
                          size: 16,
                        ),
                        My_Text(
                          data: ' ${controller.todolistfull.length}',
                          size: 40,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 35,
                              right: 60,
                              child: My_Text(
                                data: '$isComplete',
                                size: 40,
                              ),
                            ),
                            const Positioned(
                              top: 28,
                              right: 45,
                              child: My_Text(
                                size: 12,
                                data: 'المكتمل',
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .38,
                              height: MediaQuery.of(context).size.width * .3,
                              child: CircularProgressIndicator(
                                  color: Fun.checkTheme() ? reColor : newColor,
                                  strokeWidth: 14,
                                  backgroundColor:
                                      Fun.checkTheme() ? pr2Color : biColor,
                                  value: isComplete ==
                                          controller.todolistfull.length
                                      ? 0
                                      : controller.todolistfull.length *
                                          isComplete /
                                          100),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const My_Text(size: 16, data: 'أجمالي عدد المفكرات'),
                        My_Text(
                          data: ' ${noteController.noteList.length}',
                          size: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .38,
                          height: MediaQuery.of(context).size.width * .3,
                          child: CircularProgressIndicator(
                            color: Fun.checkTheme() ? pr2Color : blColor,
                            strokeWidth: 14,
                            backgroundColor:
                                Fun.checkTheme() ? biColor : prColor,
                            value: noteController.noteList.length / 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _reportTabs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: ClipOval(
            child: Image.asset(
              Kh1,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 50,
              onPressed: () {
                Uri url = Uri.parse(
                    'https://www.facebook.com/profile.php?id=100000855463020');

                _launchInBrowser(url);
              },
              icon: const Icon(
                Icons.facebook,
              ),
            ),
            Tooltip(
              message: 'لا يوجد ',
              child: IconButton(
                iconSize: 50,
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
            ),
          ],
        ),
        const My_Text(
          data:
              '                                 خالد جمال \n الحمدالله رب العالمين \n اول تطبيق اقوم بتنفيذه 😍🌴💐 \n والله الموفق والمستعان ..........🤲🤲',
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
