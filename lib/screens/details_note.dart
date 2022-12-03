// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_stats/string_stats.dart';

import '../binding.dart/binding.dart';
import '../controller/note_controller.dart';
import '/model/note_model.dart';
import '/ui/widget/fun.dart';
import '../ui/constant/component.dart';
import '../ui/constant/themes.dart';
import 'edit_note.dart';

class DetailsNote extends StatefulWidget {
  NoteModel model;
  DetailsNote({required this.model, super.key});

  @override
  State<DetailsNote> createState() => _DetailsNoteState();
}

class _DetailsNoteState extends State<DetailsNote> {
  final controller = Get.find<NoteController>();
  @override
  Widget build(BuildContext context) {
    // final i = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      controller.titleController.text = widget.model.title!;
      controller.noteController.text = widget.model.body!;
      controller.colorIndex.value = widget.model.color!;
      controller.contentWordCount.value = wordCount(widget.model.body!);
      controller.contentCharCount.value = charCount(widget.model.body!);
    });

    return Scaffold(
      backgroundColor: Fun.checkTheme() ? blColor : null,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => EditNote(note: widget.model),
                duration: const Duration(seconds: 1),
                transition: Transition.size,
                curve: Curves.easeInOut,
                arguments: widget.model,
                binding: MyBinding(),
              );
              setState(() {});
            },
            icon: const Icon(Icons.edit_calendar_outlined),
            iconSize: 35,
          ),
          IconButton(
            onPressed: () {
              controller.deleteNote(widget.model.id.toString());
              Get.back();
            },
            icon: const Icon(Icons.delete_forever_sharp),
            iconSize: 35,
          ),
          IconButton(
            onPressed: () {
              controller.shareNote(
                  ' عنوان المفكرة :: ${widget.model.title!}\n محتوى المفكرة  :: ${widget.model.body!}',
                  widget.model.body!);
            },
            icon: const Icon(Icons.share_outlined),
            iconSize: 35,
          ),
        ],
        elevation: 0,
        backgroundColor: Fun.checkTheme() ? blColor : null,
        title: SizedBox(
          height: 50,
          child: Image.asset(
            'assets/images/3.PNG',
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Fun.checkTheme()
                  ? Image.asset(
                      'assets/images/13.png',
                      fit: BoxFit.fitHeight,
                    )
                  : null,
            ),
            SelectionArea(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: My_Text(
                      size: 20,
                      data:
                          ' ${widget.model.title!.isEmpty ? 'بدون عنوان' : widget.model.title}',
                      maxline: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 510,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: My_Text(
                              overflow: null,
                              data: ' ${widget.model.body}',
                              maxline: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const My_Text(
                            data: 'تم الأنشاء في: ',
                            size: 15,
                          ),
                          My_Text(
                            fontFamily: '',
                            data: ' ${widget.model.dateTimeCreated}',
                            size: 12,
                          ),
                        ],
                      ),
                      widget.model.dateTimeEdited != null
                          ? Row(
                              children: [
                                const My_Text(
                                  data: 'تم التعديل في : ',
                                  size: 15,
                                ),
                                My_Text(
                                  fontFamily: '',
                                  data: ' ${widget.model.dateTimeEdited}',
                                  size: 12,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const My_Text(
                            color: prColor,
                            data: ' عدد الكلمات: ',
                            size: 15,
                          ),
                          My_Text(
                            data: '${controller.contentWordCount.value}',
                            size: 30,
                            color: biColor,
                          ),
                          const My_Text(
                            data: ' عدد الحروف: ',
                            size: 15,
                          ),
                          My_Text(
                            color: biColor,
                            data: '${controller.contentCharCount.value}',
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
