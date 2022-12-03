import 'package:get/get.dart';

import '../controller/note_controller.dart';
import '../controller/todo_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToDoController>(() => ToDoController(), fenix: true);

    Get.put(NoteController(), permanent: true);
    // Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
  }
}
