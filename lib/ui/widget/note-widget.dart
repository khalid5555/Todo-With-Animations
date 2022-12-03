// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/note_controller.dart';
import '/model/note_model.dart';
import '../constant/component.dart';
import '../constant/themes.dart';
import 'fun.dart';

class NoteWidget extends GetView<NoteController> {
  // HomeController controller = Get.find<HomeController>();
  NoteWidget({super.key, required this.model});

  NoteModel model;
// GestureDetector(
//       onLongPress: () => controller.delete(model),
//       onTap: () {
//         Get.to(DetailsTask(model: model),
//             duration: const Duration(seconds: 1),
//             transition: Transition.size,
//             curve: Curves.easeInOut,
//             binding: MyBinding(),
//             arguments: model);
//       },)
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      curve: Curves.bounceInOut,
      child: Card(
        shadowColor: newColor,
        color: (model.color == 0
            ? prColor
            : model.color == 1
                ? scColor
                : model.color == 2
                    ? reColor
                    : model.color == 3
                        ? grColor
                        : model.color == 4
                            ? ylColor
                            : biColor),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
              color: Color.fromARGB(255, 245, 109, 60),
              width: 1,
              strokeAlign: StrokeAlign.center),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 1,
              child: Transform.rotate(
                angle: 6,
                origin: const Offset(-65, 20),
                child: SizedBox(
                  height: 50,
                  width: 25,
                  child: Icon(
                    Icons.event_available_sharp,
                    size: 30,
                    color: Fun.recolor(),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 5, bottom: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    My_Text(
                      data: model.title == '' ? 'بدون عنوان' : '${model.title}',
                      size: 12,
                    ),
                    const SizedBox(height: 5),
                    My_Text(
                      fontFamily: '',
                      data: '${model.dateTimeCreated}',
                      size: 9,
                    ),
                    const SizedBox(height: 5),
                    My_Text(
                      size: 10,
                      overflow: TextOverflow.ellipsis,
                      data: '${model.body}',
                      maxline: 7,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




































// class Note extends StatelessWidget {
//   TodoModel model = TodoModel();
//   Note(this.model, {super.key});
//   HomeController controller = Get.put(HomeController());
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: model.color == 1 ? Colors.green : null,
//       elevation: 18,
//       clipBehavior: Clip.hardEdge,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 10, left: 5, bottom: 10),
//         child: Stack(
//           alignment: AlignmentDirectional.topEnd,
//           children: [
//             const Positioned(
//               child: Icon(
//                 Icons.push_pin_outlined,
//                 size: 25,
//                 color: Color.fromARGB(255, 251, 9, 215),
//               ),
//             ),
//             SizedBox(
//               width: Get.width / 2.55,
//               height: Get.height / 3.45,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   my_Text(
//                     data: '${model.title}',
//                     size: 15,
//                   ),
//                   const SizedBox(height: 5),
//                   Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: my_Text(
//                       data: '${model.date}',
//                       size: 10,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: my_Text(size: 12, data: '${model.task}'),
//                   ),
//                   Flexible(
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.height,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       my_Text(
//                         data: '${model.remind}',
//                         size: 10,
//                       ),
//                       const SizedBox(width: 5),
//                       model.repeat == null
//                           ? Container()
//                           : const Icon(Icons.repeat),
//                       my_Text(
//                         data: '${model.startTime}',
//                         size: 10,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
