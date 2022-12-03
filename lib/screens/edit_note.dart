// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/constant/themes.dart';
import '/ui/widget/fun.dart';
import '../controller/note_controller.dart';
import '../model/note_model.dart';
import 'home.dart';

class EditNote extends StatefulWidget {
  EditNote({Key? key, required this.note}) : super(key: key);
  NoteModel note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final controller = Get.find<NoteController>();

  @override
  void initState() {
    super.initState();

    controller.titleController.text = widget.note.title!;
    controller.noteController.text = widget.note.body!;
    controller.colorIndex.value = widget.note.color!;
  }

  @override
  Widget build(BuildContext context) {
    // final i = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تعديل المفكرة',
          style: TextStyle(color: pr2Color),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
            // setState(() {});
          },
          icon: const Icon(Icons.clear, color: pr2Color),
        ),
        backgroundColor: Fun.checkTheme() ? blColor : null,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.updater(widget.note);

              Get.offAll(() => HomeScreen());
              // setState(() {});
            },
            icon: Image.asset(
              KPICN3,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 12.0, top: 10.0, bottom: 5.0),
            child: TextField(
              // cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
              cursorWidth: 4.0,
              textInputAction: TextInputAction.next,
              cursorRadius: const Radius.circular(20.0),
              style: subheading,
              controller: controller.titleController,
              minLines: 1,
              maxLines: 20,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(5.0),
                  hintText: 'عنوان للمفكرة (اختياري)',
                  hintStyle: TextStyle(color: prColor)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Divider(thickness: 0.5, color: prColor),
          ),

          //!section colors
          colorSelected(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Divider(thickness: 0.5, color: prColor),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              child: TextField(
                // cursorColor:
                //     Theme.of(context).textSelectionTheme.cursorColor,
                cursorWidth: 3.0,

                style: const TextStyle(fontSize: 16.0, color: prColor),
                // autofocus: true,
                controller: controller.noteController,
                minLines: 7,
                maxLines: null,

                // mouseCursor: MouseCursor.defer,

                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    enabled: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5.0),
                    hintText: 'اضف المفكرة ...........📝',
                    hintStyle: TextStyle(color: prColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget colorSelected() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              children: List<Widget>.generate(
                6,
                (int index) {
                  return GestureDetector(
                    onTap: () {
                      controller.colorIndex.value = index;
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
                      child: index == controller.colorIndex.value
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
      ),
    );
  }
}
