// ignore_for_file: unused_field, avoid_print

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../binding.dart/binding.dart';
import '../controller/todo_controller.dart';
import '../db/notfication_helper.dart';
import '../model/todo_model.dart';
import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import '../ui/widget/empty_todo_page.dart';
import '../ui/widget/fun.dart';
import '../ui/widget/todo-widget.dart';
import 'edit_todo.dart';
import 'new-todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ToDoController controller = Get.find<ToDoController>();
  final notify = NotificationHelper();
  double topCalendar = 0;

  bool _closeCalendar = true;
  String _date = Fun.formatDate(DateTime.now());
  bool _isFuture = false;
  bool _isScrollEnd = false;
  double _offset = 0.0;
  final ScrollController _scrollController = ScrollController();
  final DateTime _today = DateTime.now();
  late List<TodoModel> _todoList;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    notify.initializeNotification();

    setTodoListByDate();
    _scrollController.addListener(() {
      double value = _scrollController.offset / 110;
      setState(() {
        if (_todoList.length > 6) {
          _isScrollEnd = _scrollController.offset >=
              _scrollController.position.maxScrollExtent - 30;
        }
        topCalendar = value;
        if (_scrollController.offset != 0.0) {
          _offset = _scrollController.offset;
        }
      });
    });
  }

  setTodoListByDate() {
    _todoList = <TodoModel>[].obs;
    setState(() {
      _todoList = controller.getTodoByDueDate(_date);
    });
  }

  dd() {
    String? ee;
    if (controller.todolistfull.isNotEmpty) {
      for (var element in controller.todolistfull) {
        print(element.date);
        ee = element.date;
      }
    }
    return ee;
  }

  buildTaskStatus() {
    var dd = controller.todolistfull.where((p0) => p0 == 'يومي').length;
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const My_Text(data: 'المهام'),
              Chip(
                label: Text(
                  "${_todoList.length += dd}",
                ),
                labelStyle: const TextStyle(
                    fontSize: 20, color: prColor, fontWeight: FontWeight.w800),
                backgroundColor: Colors.teal.shade100,
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(10.0),
                shadowColor: MaterialStateProperty.all(prColor),
                backgroundColor: MaterialStateProperty.all(prColor),
                foregroundColor: MaterialStateProperty.all(pr2Color),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    _closeCalendar = !_closeCalendar;
                    if (_todoList.isNotEmpty) {
                      _scrollController.animateTo(
                        0.0,
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _date,
                    style: const TextStyle(fontSize: 13.0, fontFamily: ''),
                  ),
                  const SizedBox(width: 5.0),
                  Icon(
                    Icons.date_range,
                    size: 20,
                    color: Colors.teal.shade100,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildCalendar() {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: _closeCalendar ? 0 : 1,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutSine,
        alignment: Alignment.topCenter,
        height: _closeCalendar ? 0 : 346,
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: prColor,
        ),
        child: Card(
          elevation: 10.0,
          color: prColor,
          //  _isDarkTheme ? Colors.white30 : Colors.white.withOpacity(0.8),
          margin: const EdgeInsets.all(0.0),
          shadowColor: pr2Color.withOpacity(.1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(55))),
          child: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (_, __) {
                return Theme(
                  data: ThemeData().copyWith(
                    colorScheme: Fun.checkTheme()
                        ? const ColorScheme.dark()
                        : const ColorScheme.light(),
                  ),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 2),
                    lastDate: DateTime(DateTime.now().year + 300, 12, 31),
                    onDateChanged: (newDate) {
                      setState(
                        () {
                          _isFuture = newDate.isAfter(_today);
                          _date = Fun.formatDate(newDate);
                          setTodoListByDate();
                          _closeCalendar = true;
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              openBuilder: (context, _) => const NewTodo(),
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
                  child: Image.asset(KPICN2, width: 35.0, height: 35.0)),
            ),
          )),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTaskStatus(),
              buildCalendar(),
              const SizedBox(height: 10.0),
              Expanded(
                  child: (controller.todolistfull.isEmpty || _todoList.isEmpty)
                      ? EmptyTodoPage(isNote: false)
                      : Obx(
                          () => MasonryGridView.count(
                            crossAxisCount: 1,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.todolistfull.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              var model = controller.todolistfull[index];
                              print('todo: ${model.toMap()}');
                              DateTime date = DateFormat.jm()
                                  .parseLoose(model.remind.toString());
                              var betime = DateFormat('HH:mm').format(date);
                              print(betime);
                              notify.scheduledNotification(
                                  int.parse(betime.toString().split(':')[0]),
                                  int.parse(betime.toString().split(':')[1]),
                                  model);
                              double scale = 1.0;
                              if (topCalendar > 0.2) {
                                scale = index + .9 - topCalendar;
                                if (scale <= 0.0) {
                                  scale = .1;
                                } else if (scale >= 1.0) {
                                  scale = 1.0;
                                }
                              }
                              if (model.repeat == 'يومي') {
                                DateTime date = DateFormat.jm()
                                    .parseLoose(model.remind.toString());
                                var betime = DateFormat('HH:mm').format(date);
                                print(betime);
                                notify.scheduledNotification(
                                    int.parse(betime.toString().split(':')[0]),
                                    int.parse(betime.toString().split(':')[1]),
                                    model);
                                return Opacity(
                                  opacity: scale,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, top: 5.0),
                                      child: Dismissible(
                                        key: Key(model.id.toString()),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          decoration: BoxDecoration(
                                            color: Fun.recolor(),
                                          ),
                                          child: const Icon(
                                            Icons.delete_forever_outlined,
                                            size: 50,
                                            color: reColor,
                                          ),
                                        ),
                                        onDismissed: (direction) {
                                          setState(
                                            () {
                                              setTodoListByDate();
                                              controller.removeTodo(
                                                  model.id.toString());
                                              controller.todolistfull
                                                  .removeWhere((todo) =>
                                                      todo.id == model.id);

                                              _scrollController.animateTo(
                                                0.0,
                                                duration: const Duration(
                                                    milliseconds: 700),
                                                curve: Curves.easeInExpo,
                                              );
                                            },
                                          );
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  () => EditToDo(model: model),
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  transition: Transition.size,
                                                  curve: Curves.easeInOut,
                                                  binding: MyBinding(),
                                                  arguments: model);
                                            },
                                            child: TodoWidget(model: model),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (model.date == _date) {
                                // DateTime date = DateFormat.jm()
                                //     .parseLoose(model.remind.toString());
                                // var betime = DateFormat("HH:mm").format(date);
                                // print(betime);
                                // notify.scheduledNotification(
                                //     int.parse(betime.toString().split(":")[0]),
                                //     int.parse(betime.toString().split(":")[1]),
                                //     model);
                                return Opacity(
                                  opacity: scale,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, top: 5.0),
                                      child: Dismissible(
                                        key: Key(model.id.toString()),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          decoration: BoxDecoration(
                                            color: Fun.recolor(),
                                          ),
                                          child: const Icon(
                                            Icons.delete_forever_outlined,
                                            size: 50,
                                            color: reColor,
                                          ),
                                        ),
                                        onDismissed: (direction) {
                                          setState(
                                            () {
                                              setTodoListByDate();
                                              controller.removeTodo(
                                                  model.id.toString());
                                              controller.todolistfull
                                                  .removeWhere((todo) =>
                                                      todo.id == model.id);

                                              _scrollController.animateTo(
                                                0.0,
                                                duration: const Duration(
                                                    milliseconds: 700),
                                                curve: Curves.easeInExpo,
                                              );
                                            },
                                          );
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  () => EditToDo(model: model),
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  transition: Transition.size,
                                                  curve: Curves.easeInOut,
                                                  binding: MyBinding(),
                                                  arguments: model);
                                            },
                                            child: TodoWidget(model: model),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                              //   // return Opacity(
                              //   //   opacity: scale,
                              //   //   child: Transform(
                              //   //     transform: Matrix4.identity()
                              //   //       ..scale(scale, scale),
                              //   //     alignment: Alignment.bottomCenter,
                              //   //     child: Padding(
                              //   //       padding: const EdgeInsets.only(
                              //   //           bottom: 10.0, top: 5.0),
                              //   //       child: Dismissible(
                              //   //         key: Key(model.id.toString()),
                              //   //         direction: DismissDirection.endToStart,
                              //   //         background: Container(
                              //   //           alignment: Alignment.centerLeft,
                              //   //           padding:
                              //   //               const EdgeInsets.only(right: 20.0),
                              //   //           decoration: BoxDecoration(
                              //   //             color: Fun.recolor(),
                              //   //           ),
                              //   //           child: const Icon(
                              //   //             Icons.delete_forever_outlined,
                              //   //             size: 50,
                              //   //             color: reColor,
                              //   //           ),
                              //   //         ),
                              //   //         onDismissed: (direction) {
                              //   //           setState(
                              //   //             () {
                              //   //               setTodoListByDate();
                              //   //               controller.removeTodo(
                              //   //                   model.id.toString());
                              //   //               controller.todolistfull.removeWhere(
                              //   //                   (todo) => todo.id == model.id);

                              //   //               _scrollController.animateTo(
                              //   //                 0.0,
                              //   //                 duration: const Duration(
                              //   //                     milliseconds: 700),
                              //   //                 curve: Curves.easeInExpo,
                              //   //               );
                              //   //             },
                              //   //           );
                              //   //         },
                              //   //         child: SizedBox(
                              //   //           width: double.infinity,
                              //   //           child: GestureDetector(
                              //   //             onTap: () {
                              //   //               Get.to(() => EditToDo(model: model),
                              //   //                   duration:
                              //   //                       const Duration(seconds: 1),
                              //   //                   transition: Transition.size,
                              //   //                   curve: Curves.easeInOut,
                              //   //                   binding: MyBinding(),
                              //   //                   arguments: model);
                              //   //             },
                              //   //             child: TodoWidget(model: model),
                              //   //           ),
                              //   //         ),
                              //   //       ),
                              //   //     ),
                              //   //   ),
                              //   // );
                            },
                          ),
                        )
                  // : Container(),
                  ),
            ],
          ),
        ),
      ),

      //!
      /*  Column(
          children: [
            buildTaskStatus(),
            buildCalendar(),
            const SizedBox(height: 20),
            _todoList.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: MasonryGridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 3,
                        controller: _noteScrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var model = _todoList[index];

                          print(model.toMap());

                          if (model.repeat == "يومي" ||
                              model.date == model.date.toString()) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              // columnCount: 2,
                              child: SlideAnimation(
                                  delay: const Duration(milliseconds: 300),
                                  child: FadeInAnimation(
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(EditTask(model: model),
                                                duration:
                                                    const Duration(seconds: 1),
                                                transition: Transition.size,
                                                curve: Curves.easeInOut,
                                                binding: MyBinding(),
                                                arguments: model);
                                          },
                                          child: NoteWidget(model: model)))),
                            );
                          }
                          // else if (model.date == model.date.toString()) {
                          //   return AnimationConfiguration.staggeredGrid(
                          //     position: index,
                          //     columnCount: 2,
                          //     child: SlideAnimation(
                          //         child: FadeInAnimation(
                          //             child: NoteWidget(model: model))),
                          //   );
                          // }
                          else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  )
                : Expanded(child: EmptyTodoPage(isNote: false)),
          ],
        ),
 */
      //!
    );
  }
}
