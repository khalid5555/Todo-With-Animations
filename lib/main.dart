import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'binding.dart/binding.dart';

import 'controller/todo_controller.dart';
import 'controller/note_controller.dart';
import 'db/todo_db_helper.dart';
import 'db/note_db_helper.dart';
import 'screens/splash.dart';
import 'ui/constant/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await ToDoDbHelper.initDb();
  await NoteDbHelper.initDb();
  // initializeControllers();
  runApp(const MyApp());
}

void initializeControllers() {
  Get.put<NoteController>(NoteController());
  // Get.put<CategoryController>(CategoryController());
  Get.put<ToDoController>(ToDoController());
  // Get.put<LoginController>(LoginController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      initialBinding: MyBinding(),
      initialRoute: '/',
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      title: 'المفكرة ',
      theme: my_themes.lt,
      themeMode: ToDoController().changeTheme,
      darkTheme: my_themes.dk,
      builder: EasyLoading.init(),
      defaultTransition: Transition.size,
      home: Splash(),
      // log ? HomeScreen() : LoginView(),
    );
  }
}
