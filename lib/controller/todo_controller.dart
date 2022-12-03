// ignore_for_file: avoid_print, unused_label, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../db/todo_db_helper.dart';
import '../model/todo_model.dart';

class ToDoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllTask();
  }

  RxList<TodoModel> todolistfull = <TodoModel>[].obs;
  // late int reminder;
  // final int startTime = int.parse(Fun.formatTime(DateTime.now()));
  // var endTime = DateFormat('   hh:mm  a  ').format(DateTime.now()).obs;
  // List reminderList = [5, 10, 15, 20, 30, 60, 120].obs;
  var repeat;
  var colorIndex = 0.obs;
  int selectedRepeatIndex = 0;
  late String selectedRepeat;
  DateTime selectDate = DateTime.now();
  late String dueDate;
  late String dueTime;

  RxInt isComplete = 0.obs;
  DateFormat dateFormat = DateFormat.yMMMEd();

  TextEditingController todoController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final _box = GetStorage();
  final keyTheme = 'isDarkMode'.obs;

  bool loadThemeBox() => _box.read(keyTheme.value) ?? false;
  ThemeMode get changeTheme =>
      loadThemeBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(loadThemeBox() ? ThemeMode.light : ThemeMode.dark);
    _saveToBox(!loadThemeBox());
  }

  void _saveToBox(bool isDarkMode) {
    _box.write(keyTheme.value, isDarkMode);
  }

  validate(BuildContext context) async {
    if (todoController.text.trim().isNotEmpty) {
      await addToDb();

      EasyLoading.showToast('تم الحفظ', duration: const Duration(seconds: 1));
      todoController.clear();
      noteController.clear();
      Get.back();
    } else {
      Get.snackbar('حقل المهمة مطلوب', 'الرجاء اضافة مهمة.......',
          forwardAnimationCurve: Curves.bounceInOut,
          reverseAnimationCurve: Curves.easeInCirc,
          icon: const Icon(Icons.back_hand_outlined, size: 40),
          backgroundColor: Colors.redAccent);
    }
    await getAllTask();
  }

  Future<int> addTaskToSql({TodoModel? task}) async {
    return await ToDoDbHelper.insertTask(task!);
  }

  upDate(TodoModel task) {
    // String id = task.id.toString();
    // int index = todolistfull.indexWhere((todo) => todo.id == id);
    // todolistfull[index] = task;
    return ToDoDbHelper.updateTodo(task);
  }

  Future<void> getAllTask() async {
    List<Map<String, dynamic>> tasks = await ToDoDbHelper.query();
    todolistfull.assignAll(tasks.map((e) => TodoModel.fromMap(e)).toList());
    print(' id todo ${tasks.length}');
  }

  // void delete(String id) async {
  //   await DbHelper.delete(id);
  //   getAllTask();
  // }

  removeTodo(String id) {
    // int index = todolistfull.indexWhere((todo) => todo.id == id);
    // todolistfull.removeAt(index);

    ToDoDbHelper.delete(id.toString());
    getAllTask();
  }

  Future<void> addToDb() async {
    int idTask = await addTaskToSql(
      task: TodoModel(
        title: todoController.text,
        todo: noteController.text,
        date: dueDate,
        remind: dueTime,
        repeat: selectedRepeat,
        color: colorIndex.value,
        isCompleted: 0,
      ),
    );

    print('my is id todo $idTask');
    todoController.clear();
    noteController.clear();
    await getAllTask();
  }

  Future<void> upDateToDb(int task) async {
    var idTask = await upDate(
      TodoModel(
        id: task,
        title: todoController.text,
        todo: noteController.text,
        date: dueDate,
        remind: dueTime,
        repeat: selectedRepeat,
        color: colorIndex.value,
        isCompleted: isComplete.value,
      ),
    );
    print('my is id todo update $idTask');
    todoController.clear();
    noteController.clear();
    EasyLoading.showToast('تم التعديل بنجاح',
        duration: const Duration(seconds: 1));
    await getAllTask();
  }

  markIsComplete(int id) async {
    await ToDoDbHelper.updateComplete(id);
    EasyLoading.showToast('اضغط على تم لحفظ التعديل',
        duration: const Duration(seconds: 1));
    getAllTask();
  }

  RxList<TodoModel> getTodoByDueDate(String dueDate) {
    RxList<TodoModel> toList = <TodoModel>[].obs;
    DateTime date = dateFormat.parseStrict(dueDate);
    for (var todo in todolistfull) {
      DateTime todoDate = dateFormat.parseStrict(todo.date!);
      bool isEqualDate = date.isAtSameMomentAs(todoDate);
      if (isEqualDate) {
        toList.add(todo);
      }
    }
    return toList;
  }

  @override
  void onClose() {
    super.onClose();
    todoController.dispose();
    noteController.dispose();
  }
}
