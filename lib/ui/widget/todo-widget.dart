// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/todo_controller.dart';
import '../../model/todo_model.dart';
import '../constant/component.dart';
import '../constant/themes.dart';
import 'fun.dart';

class TodoWidget extends GetView<ToDoController> {
  TodoWidget({super.key, required this.model});

  TodoModel model;
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
      duration: const Duration(seconds: 2),
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
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Color.fromARGB(255, 245, 109, 60),
            width: 1,
            strokeAlign: StrokeAlign.center,
          ),
        ),
        child: Stack(
          children: [
            if (model.isCompleted == 1)
              const Center(
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: pr2Color,
                ),
              ),
            Positioned(
              left: 1,
              child: Transform.rotate(
                  angle: 2.8,
                  origin: const Offset(0, -5),
                  child: Container(
                    height: 40,
                    width: 20,
                    color: Fun.recolor(),
                  )),
            ),
            // Positioned(
            //   bottom: 28,
            //   left: 1,
            //   child: Checkbox(
            //     splashRadius: 20,
            //     value: model.isCompleted == 1 ? true : false,
            //     onChanged: (bool? value) {
            //       controller.isComplete.value = 1;
            //       controller.markIsComplete(model.id!);
            //       if (value!) {
            //         controller.isComplete.value = 1;
            //         model.isCompleted = 1;
            //       } else {
            //         model.isCompleted = 0;
            //         controller.isComplete.value = 0;
            //       }
            //     },
            //   ),
            // ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 5, bottom: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    My_Text(
                      decoration: model.isCompleted == 1
                          ? TextDecoration.lineThrough
                          : null,
                      maxline: 2,
                      data: '${model.title}',
                      size: 14,
                    ),
                    const SizedBox(height: 5),
                    My_Text(
                      decoration: model.isCompleted == 1
                          ? TextDecoration.lineThrough
                          : null,
                      fontFamily: '',
                      data: '${model.date}',
                      size: 9,
                    ),
                    const SizedBox(height: 5),
                    My_Text(
                      size: 12,
                      decoration: model.isCompleted == 1
                          ? TextDecoration.lineThrough
                          : null,
                      data: '${model.todo}'.isEmpty
                          ? 'لا يوجد تفاصيل للمهمة'
                          : '${model.todo}',
                      maxline: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 5),
                        My_Text(
                          size: 12,
                          decoration: model.isCompleted == 1
                              ? TextDecoration.lineThrough
                              : null,
                          data: '${model.repeat}',
                          maxline: 6,
                        ),
                        const SizedBox(height: 5),
                        My_Text(
                          fontFamily: '',
                          size: 9,
                          data: 'الساعة ${model.remind}',
                          maxline: 6,
                        ),
                        const SizedBox(height: 5),
                        Transform.rotate(
                          angle: model.isCompleted == 1 ? 1.5 : 0,
                          origin: model.isCompleted == 1
                              ? const Offset(0, -30)
                              : const Offset(0, 0),
                          child: My_Text(
                            size: 15,
                            data: model.isCompleted == 1
                                ? ' مهمة مكتملة'
                                : '  لم تكتمل',
                            maxline: 6,
                          ),
                          //  Icon(
                          //   Icons.event_available_rounded,
                          //   size: 38,
                          //   color: Fun.recolor(),
                          // ),
                        ),
                      ],
                    ),
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
