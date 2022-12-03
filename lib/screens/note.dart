// ignore_for_file: avoid_print

import 'package:animations/animations.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../binding.dart/binding.dart';
import '../controller/note_controller.dart';
import '../controller/todo_controller.dart';
import '../screens/new_note.dart';
import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import '../ui/widget/empty_todo_page.dart';
import '../ui/widget/fun.dart';
import '../ui/widget/note-widget.dart';
import '../ui/widget/searchbar.dart';
import 'details_note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final ScrollController _noteScrollController = ScrollController();
  final NoteController controller = Get.find<NoteController>();
  final ToDoController controllerH = Get.find<ToDoController>();
  final bool _isScrollEnd = false;

  @override
  Widget build(BuildContext context) {
    // final i = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      floatingActionButton: Visibility(
          visible: !_isScrollEnd,
          child: Card(
            margin: const EdgeInsets.all(0.0),
            elevation: 20.0,
            shadowColor: prColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: pr2Color,
            child: OpenContainer(
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: const Duration(seconds: 1),
              openBuilder: (context, _) => const AddNote(),
              closedShape: const CircleBorder(),
              openColor: biColor,
              middleColor: prColor,
              closedColor: prColor,
              closedElevation: 0.0,
              closedBuilder: (context, openContainer) => FloatingActionButton(
                  mini: true,
                  onPressed: openContainer,
                  backgroundColor: Colors.transparent,
                  elevation: 20.0,
                  child: Image.asset(KPICN1, width: 35.0, height: 35.0)),
            ),
          )),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addTaskBar(),
            // _appBar(),
            const SizedBox(height: 5),
            datePickerTimeline(),
            const SizedBox(height: 10),
            controller.noteList.isNotEmpty
                ? Expanded(
                    flex: 1,
                    child: Obx(
                      () => MasonryGridView.count(
                        controller: _noteScrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.noteList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var model = controller.noteList[index].obs;
                          print('note: ${model.value.toMap()}');
                          {
                            return Obx(
                              () => AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 2,
                                child: SlideAnimation(
                                  child: ScaleAnimation(
                                    duration: const Duration(seconds: 1),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            () =>
                                                DetailsNote(model: model.value),
                                            duration:
                                                const Duration(seconds: 1),
                                            transition: Transition.size,
                                            curve: Curves.easeInOut,
                                            binding: MyBinding(),
                                            arguments: index);
                                      },
                                      child: NoteWidget(model: model.value),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 3,
                      ),
                    ),
                  )
                : Expanded(child: EmptyTodoPage(isNote: true)),
          ],
        ),
      ),
    );
  }

  datePickerTimeline() {
    return DatePicker(
      DateTime.now(),
      locale: 'AR',
      width: 80,
      height: 100,
      selectionColor: prColor,
      dateTextStyle: subheading.copyWith(
          fontSize: 24, color: biColor, fontWeight: FontWeight.bold),
      monthTextStyle:
          subheading.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
      dayTextStyle:
          subheading.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
      initialSelectedDate: DateTime.now(),
      onDateChange: (date) {
        setState(() {
          controllerH.selectDate = date;
        });
      },
    );
  }

  Color rerun() {
    late Color my;
    setState(() {});
    my = Fun.checkTheme() ? biColor : prColor;

    return my;
  }

  addTaskBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 5),
        My_Text(
          size: 30,
          data: 'الـــيوم',
          color: Fun.recolor(),
        ),
        const SizedBox(width: 35),
        My_Text(
          size: 30,
          color: rerun(),
          data: DateFormat('dd / MM / yyyy ').format(DateTime.now()).toString(),
        ),
        const SizedBox(width: 35),
        IconButton(
          focusColor: biColor,
          iconSize: 36,
          icon: const Icon(Icons.search_outlined),
          onPressed: () {
            showSearch(context: context, delegate: SearchBar());
          },
        ),
      ],
    );
  }

  // _appBar() {
  //   return AppBar(
  //     backgroundColor: Fun.checkTheme() ? blColor : null,
  //     elevation: 0,
  //     actions: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         child: IconButton(
  //           onPressed: () {
  //             controllerH.switchTheme();

  //  setState(() {});
  //           },
  //           icon: Icon(
  //             Fun.checkTheme() ? Icons.sunny : Icons.mode_night,
  //           ),
  //         ),
  //       ),
  //     ],
  //     title: SizedBox(
  //       height: 50,
  //       child: Image.asset(
  //         'assets/images/3.PNG',
  //         fit: BoxFit.fill,
  //       ),
  //     ),
  //   );
  // }

}
