// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';
import '../model/todo_model.dart';
import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import '/ui/widget/fun.dart';

class EditToDo extends StatefulWidget {
  TodoModel model;
  EditToDo({Key? key, required this.model}) : super(key: key);

  @override
  State<EditToDo> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  final ToDoController Ctrl = Get.find<ToDoController>();

  bool isEdit = false;
  String title = 'مهمة جديدة';

  // late String _dueTime;

  @override
  void initState() {
    super.initState();
    Ctrl.todoController.text = widget.model.title!;
    Ctrl.noteController.text = widget.model.todo!;
    Ctrl.colorIndex.value = widget.model.color!;
    Ctrl.dueTime = widget.model.remind!;
    checkMode();
    isEdit = true;
  }

  checkMode() {
    if (isEdit) {
      setState(
        () {
          Ctrl.dueDate = Fun.formatDate(Ctrl.selectDate);

          title = 'تعديل';
        },
      );

      // setTodoData();
    } else {
      Ctrl.selectedRepeat =
          Fun.getRepeatTypes(REPEAT_TYPES.values[Ctrl.selectedRepeatIndex]);
      Ctrl.dueDate = Fun.formatDate(Ctrl.selectDate);
      Ctrl.dueTime = Fun.formatTime(DateTime.now());
    }
  }

  Widget AddNew(BuildContext context) {
    return Form(
      key: Ctrl.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            titleInput(),
            buildDivider(),
            Date_pick(),
            const SizedBox(height: 5),
            buildDivider(),
            timeReminder(),
            const SizedBox(height: 5),
            buildDivider(),
            repeatTask(),
            const SizedBox(height: 5),
            buildDivider(),
            //!section colors
            const SizedBox(height: 22),
            colorSelected(),
            note(),
            const SizedBox(height: 8),
            // row_Button(context),
          ],
        ),
      ),
    );
  }

//!section colors
  Widget colorSelected() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            children: List<Widget>.generate(
              6,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    Ctrl.colorIndex.value = index;
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: (index == 0
                        ? prColor
                        : index == 1
                            ? scColor
                            : index == 2
                                ? reColor
                                : index == 3
                                    ? grColor
                                    : index == 4
                                        ? ylColor
                                        : biColor),
                    child: index == Ctrl.colorIndex.value
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : Container(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 3,
      thickness: 1,
      color: prColor.withOpacity(0.9),
    );
  }

  TextField titleInput() {
    return TextField(
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      cursorColor: Fun.checkTheme() ? biColor : prColor,
      cursorWidth: 3,
      cursorRadius: const Radius.circular(55),
      style: Fun.checkTheme() ? inPutStyle : inPutStyle,
      controller: Ctrl.todoController,
      minLines: 7,
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabled: true,
        hintText: widget.model.todo,
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Fun.checkTheme() ? prColor : biColor),
      ),
    );
  }

  // Padding row_Button(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         MyButton(
  //           width: 150,
  //           label: 'اضافة مهمة',
  //           onTap: () {
  //             controller.validate(context);
  //             Get.back();
  //           },
  //         ),
  //         MyButton(
  //           width: 150,
  //           onTap: () {
  //             Get.back();
  //             // controller.titleController.clear();
  //             controller.todoController.clear();
  //             // controller.dateController.clear();
  //           },
  //           label: 'ألغاء',
  //         )
  //       ],
  //     ),
  //   );
  // }

  ListTile Date_pick() {
    return ListTile(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: Ctrl.selectDate,
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 100),
          builder: (context, child) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Theme(
                  data: ThemeData().copyWith(
                    colorScheme: const ColorScheme.light().copyWith(
                      primary: prColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );
          },
        );
        if (pickedDate != null && pickedDate != Ctrl.selectDate) {
          setState(
            () {
              Ctrl.selectDate = pickedDate;
              Ctrl.dueDate = Fun.formatDate(Ctrl.selectDate);
            },
          );
        }
      },
      horizontalTitleGap: 0,
      leading: const Icon(
        Icons.calendar_month_rounded,
        size: 30,
        color: prColor,
      ),
      title: const My_Text(size: 14, data: 'التاريخ', color: prColor),
      trailing: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(prColor),
        ),
        onPressed: null,
        child: My_Text(
          fontFamily: '',
          size: 14,
          data: widget.model.date!,
          color: pr2Color,
        ),
      ),
    );
  }

  ListTile timeReminder() {
    return ListTile(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.30,
              decoration: BoxDecoration(
                color: Fun.checkTheme() ? Colors.white60 : prColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  setState(() {
                    Ctrl.dueTime = Fun.formatTime(value);
                    // widget.model.remind = controller.dueTime;
                  });
                },
                initialDateTime: Fun.getTime(Ctrl.dueTime),
              ),
            );
          },
        );
      },
      horizontalTitleGap: 1,
      leading: Image.asset(
        KPICN3,
        fit: BoxFit.scaleDown,
        width: 30.0,
        height: 30.0,
      ),
      title: const My_Text(size: 14, data: 'التذكير', color: prColor),
      trailing: SizedBox(
        width: 150,
        child: TextButton(
          style:
              ButtonStyle(backgroundColor: MaterialStateProperty.all(prColor)),
          onPressed: null,
          child: My_Text(
              fontFamily: '',
              size: 14,
              data: widget.model.remind!,
              color: pr2Color),
        ),
      ),
    );
  }

  changeRepeatType() {
    setState(() {
      Ctrl.selectedRepeat =
          Fun.getRepeatTypes(REPEAT_TYPES.values[Ctrl.selectedRepeatIndex]);
      Get.back();
    });
  }

  ListTile repeatTask() {
    return ListTile(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 40,
                          color: prColor,
                          padding: const EdgeInsets.only(left: 30),
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Get.back(),
                        ),
                        IconButton(
                          iconSize: 40,
                          color: prColor,
                          onPressed: () => changeRepeatType(),
                          icon: const Icon(Icons.check_circle),
                        ),
                      ],
                    ),
                  ],
                  title: const My_Text(data: 'التكرار'),
                  content: SizedBox(
                    width: 200,
                    height: 130,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: List.generate(
                        REPEAT_TYPES.values.length,
                        (index) => ChoiceChip(
                            padding: const EdgeInsets.all(8),
                            labelStyle: Ctrl.selectedRepeatIndex == index
                                ? inPutStyle.copyWith(color: Colors.white)
                                : inPutStyle,
                            label: My_Text(
                              size: 14,
                              data: Fun.getRepeatTypes(
                                  REPEAT_TYPES.values[index]),
                            ),
                            selected: Ctrl.selectedRepeatIndex == index
                                ? true
                                : false,
                            onSelected: (bool isSelected) {
                              if (isSelected) {
                                setState(
                                  () {
                                    Ctrl.selectedRepeatIndex = index;
                                  },
                                );
                              }
                            },
                            backgroundColor: biColor.withOpacity(0.3),
                            selectedColor: prColor),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      horizontalTitleGap: 0.0,
      leading: const Icon(
        Icons.repeat_rounded,
        color: prColor,
        size: 30,
      ),
      title: const My_Text(size: 16, data: 'التكرار', color: prColor),
      trailing: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(prColor),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 29))),
        onPressed: null,
        child: My_Text(
          size: 16,
          data: widget.model.repeat!,
          color: pr2Color,
        ),
      ),
    );
  }

  ListTile note() {
    return ListTile(
      horizontalTitleGap: 0.0,
      isThreeLine: true,
      leading: Image.asset(
        KPICN2,
        fit: BoxFit.scaleDown,
        width: 30,
        height: 100,
      ),
      minVerticalPadding: 10.0,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextField(
          controller:
              Ctrl.noteController.text == null ? null : Ctrl.noteController,
          maxLines: null,
          minLines: 3,
          cursorColor: biColor,
          style: inPutStyle,
          focusNode: FocusNode().parent,
          textInputAction: TextInputAction.newline,
          decoration: const InputDecoration(
            hintText: 'اضافة مفكرة للمهمة',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: pr2Color),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(22),
              ),
              borderSide: BorderSide(width: 0.5, color: prColor),
            ),
          ),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // final i = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Ctrl.loadThemeBox() ? blColor : pr2Color,
      appBar: AppBar(
        actions: [
          IconButton(
            iconSize: 30,
            color: prColor,
            padding: const EdgeInsets.only(left: 30),
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Get.back(),
          ),
          IconButton(
            iconSize: 30,
            color: prColor,
            padding: const EdgeInsets.only(left: 30),
            icon: My_Text(
                data:
                    widget.model.isCompleted == 1 ? 'تمت المهمة' : 'لم تكتمل'),
            onPressed: () {
              if (widget.model.isCompleted == 0) {
                setState(() {
                  Ctrl.isComplete.value = 1;
                  Ctrl.markIsComplete(widget.model.id!);
                  EasyLoading.showToast('اضغط على تم \n لحفظ التعديل',
                      duration: const Duration(seconds: 1));
                });
              } else if (widget.model.isCompleted == 1) {
                setState(() {
                  Ctrl.isComplete.value = 0;
                  Ctrl.markIsComplete(widget.model.id!);
                  EasyLoading.showToast('اضغط على تم \n لحفظ التعديل',
                      duration: const Duration(seconds: 1));
                });
              }
            },
          ),
        ],
        leading: IconButton(
          color: prColor,
          iconSize: 40,
          padding: const EdgeInsets.only(right: 30),
          icon: const Icon(Icons.check_circle),
          onPressed: () async {
            await Ctrl.upDateToDb(int.parse(widget.model.id.toString()));
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: My_Text(
          data: isEdit ? 'تعديل' : title,
          size: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: Fun.checkTheme()
                  ? Opacity(
                      opacity: .3,
                      child: Image.asset(
                        'assets/images/13.png',
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : null,
            ),
            SizedBox(
              child: AddNew(context),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// show_Date_Picker(context) async {
//   final DateTime? select = await showDatePicker(
//     builder: (context, child) {
//       return Theme(
//         data: ThemeData().copyWith(
//           colorScheme: const ColorScheme.light().copyWith(
//             primary: prColor,
//           ),
//         ),
//         child: child!,
//       );
//     },
//     context: context,
//     firstDate: DateTime.now(),
//     // currentDate: DateTime.now(),
//     initialDate: DateTime.now(),
//     lastDate: DateTime(DateTime.now().year + 300, 12, 31),
//   );
//   if (select != null) {
//     // if (select.isBefore(DateTime(DateTime.now().day))) {
//     //   debugPrint('some thing is waring');
//     // } else
//     if (select.isAfter(DateTime.now())) {
//       controller.dateController.text =
//           DateFormat('dd / MM / yyyy').format(select);
//     } else {
//       controller.dateController.text =
//           DateFormat('dd / MM / yyyy').format(select);
//     }
//   } else {
//     debugPrint('some thing is waring');
//   }
// }

// getTimeFromUser(context, bool isStartTime) async {
//   var show = await _showTimePicker(context);

//   String pickTime = show!.format(context);
//   if (show == null) {
//     return debugPrint('some thing is waring');
//   } else if (isStartTime == true) {
//     controller.startTime.value = pickTime;
//     controller.startCtl.text = pickTime;
//   } else if (isStartTime == false) {
//     controller.endTime.value = pickTime;
//     // controller.endCtl.text = pickTime;
//   }
// }

// _showTimePicker(context) {
//   return showTimePicker(
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData().copyWith(
//             colorScheme: const ColorScheme.light().copyWith(
//               primary: prColor,
//             ),
//           ),
//           child: child!,
//         );
//       },
//       context: context,
//       initialTime: TimeOfDay(
//           hour: int.parse(controller.startTime.value.split(':')[0]),
//           minute: int.parse(
//               controller.startTime.value.split(':')[1].split(' ')[0])));
// }
