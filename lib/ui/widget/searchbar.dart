import 'package:Time_Do/controller/note_controller.dart';
import 'package:Time_Do/model/note_model.dart';
import 'package:Time_Do/screens/details_note.dart';
import 'package:Time_Do/ui/constant/component.dart';
import 'package:Time_Do/ui/widget/fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchBar extends SearchDelegate {
  final NoteController controller = Get.find<NoteController>();
  var model = NoteModel();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null!;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? controller.noteList
        : controller.noteList.where(
            (value) {
              return value.title!.contains(query.toLowerCase()) ||
                  value.body!.contains(query.toLowerCase());
            },
          ).toList();
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: MasonryGridView.count(
        itemCount: suggestionList.length,
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        // staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          var searchList = suggestionList[index];
          return GestureDetector(
            onTap: () {
              Get.to(DetailsNote(model: searchList), arguments: searchList);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Fun.recolor(),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(5, 5),
                      blurRadius: 5)
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchList.title == ''
                        ? 'بدون عنوان'
                        : searchList.title.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    searchList.body.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 6,
                  ),
                  const SizedBox(height: 10),
                  My_Text(
                    size: 10,
                    fontFamily: '',
                    data: searchList.dateTimeCreated.toString(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
