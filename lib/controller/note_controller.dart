// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

// import 'package:share/share.dart';

import '../db/note_db_helper.dart';
import '../model/note_model.dart';
import '../ui/constant/themes.dart';
import '../ui/widget/fun.dart';

class NoteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAllNotes();
  }

  RxList<NoteModel> noteList = <NoteModel>[].obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final NoteModel model = NoteModel();
  // int get noteListLength => noteList.length;
  // late CategoryController catController;
  var colorIndex = 0.obs;
  RxInt contentWordCount = 0.obs;
  RxInt contentCharCount = 0.obs;
  Future<int> addTaskToSql({NoteModel? newNote}) async {
    return await NoteDbHelper.insertNote(newNote!);
  }

  validateNote() async {
    if (noteController.text.trim().isNotEmpty) {
      await addNote();
      EasyLoading.showToast('تم الحفظ', duration: const Duration(seconds: 1));
      titleController.clear();
      noteController.clear();
      getAllNotes();
      Get.back();
    } else {
      return Get.snackbar(
        'حقل تفاصيل المفكرة مطلوب',
        'الرجاء اضافة مفكرة...',
        forwardAnimationCurve: Curves.bounceInOut,
        reverseAnimationCurve: Curves.easeInCirc,
        borderWidth: 2,
        borderColor: prColor,
        icon: const Icon(
          Icons.back_hand_outlined,
          size: 50,
        ),
        backgroundColor: Colors.redAccent,
      );
    }
    await getAllNotes();
  }

  Future<void> addNote() async {
    String title = titleController.text.trim();
    String content = noteController.text.trim();
    var idTask = await addTaskToSql(
      newNote: NoteModel(
        categoryId: null,
        title: title,
        body: content,
        color: colorIndex.value,
        dateTimeEdited: null,
        dateTimeCreated: Fun.formatDate(DateTime.now()),
      ),
    );
    contentWordCount.value = wordCount(content);
    contentCharCount.value = charCount(content);
    print('my is id noteee $idTask');
  }

  Future<void> getAllNotes() async {
    List<Map<String, dynamic>> note = await NoteDbHelper.getNotes();

    noteList.assignAll(note.map((e) => NoteModel.fromMap(e)).toList());

    print(' id note ${note.length}');
  }

  updateNote(NoteModel editedNote) async {
    // String id = editedNote.id.toString();
    // int index =
    //     noteList.indexWhere((note) => note.id == id);
    // noteList = editedNote;
    await NoteDbHelper.updateNote(editedNote).then((value) => (value) {
          EasyLoading.showToast('تم التعديل بنجاح',
              duration: const Duration(seconds: 1));
          titleController.clear();
          noteController.clear();
          getAllNotes();
        });
  }

  Future<void> updater(NoteModel note) async {
    String title = titleController.text.trim();
    String content = noteController.text.trim();
    var idTask = await updateNote(
      NoteModel(
        id: note.id,
        categoryId: null,
        title: title,
        body: content,
        color: colorIndex.value,
        dateTimeEdited: Fun.formatDate(DateTime.now()),
        dateTimeCreated: model.dateTimeCreated,
      ),
    );
    contentWordCount.value = wordCount(content);
    contentCharCount.value = charCount(content);
    print('my update noteee $idTask');
    // titleController.clear();
    // noteController.clear();
    await getAllNotes();
  }

  deleteNote(String id) {
    noteList.removeWhere((note) => note.id == id);
    NoteDbHelper.deleteNote(id);
    getAllNotes();
  }

  void shareNote(String title, String content) {
    Share.share(title, subject: content, sharePositionOrigin: Rect.largest);
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    noteController.dispose();
  }
}
