// ignore_for_file: must_be_immutable

import 'package:Time_Do/ui/constant/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/constant/themes.dart';
import '/ui/widget/fun.dart';
import '../controller/note_controller.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool isEdit = false;
  String appBarTitle = 'اضافة مفكرة';

  final controller = Get.find<NoteController>();

  @override
  void initState() {
    super.initState();

    setState(() {
      controller.noteController.text = '';
      controller.titleController.text = '';
      controller.colorIndex.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      controller.noteController.text = '';
      controller.titleController.text = '';
      controller.colorIndex.value = 0;
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: My_Text(
          data: appBarTitle,
          color: Fun.checkTheme() ? prColor : biColor,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.clear, color: Fun.checkTheme() ? prColor : biColor),
        ),
        backgroundColor: Fun.checkTheme() ? blColor : null,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.validateNote();
            },
            icon: Image.asset(
              KPICN1,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
              child: TextField(
                cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                cursorWidth: 4.0,
                cursorRadius: const Radius.circular(20.0),
                style: subheading,
                controller: controller.titleController,
                minLines: 2,
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5.0),
                    hintText: 'عنوان للمفكرة               (اختياري)',
                    hintStyle: TextStyle(color: prColor)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(thickness: 1, color: prColor),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: SizedBox(
            //     height: 50.0,
            //     child: Container(
            //       decoration:
            //           BoxDecoration(borderRadius: BorderRadius.circular(22)),
            //       child: TextButton(
            //           // onPressed: () {}, child: my_Text(data: _selectedCat.name)),
            //     ),
            //!section colors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Obx(() => Row(
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
                  )),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(
                thickness: 1,
                color: prColor,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: TextField(
                cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                cursorWidth: 3.0,
                cursorRadius: const Radius.circular(20.0),
                style: const TextStyle(
                    fontSize: 19.0, height: 1.4, color: prColor),
                // autofocus: true,
                controller: controller.noteController,
                minLines: 7,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5.0),
                    hintText: 'اضف المفكرة ...........📝',
                    hintStyle: TextStyle(color: prColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
