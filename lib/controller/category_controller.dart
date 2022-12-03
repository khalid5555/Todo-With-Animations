import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db/category_db_helper.dart';
import '../model/cat_model.dart';

enum CATEGORY_COLORS { teal, orange, green, blueGrey, blue, brown }

enum DEFAULT_CAT_NAMES { all, personal, work, entertainment, study, poem }

class CategoryController extends GetxController
    with StateMixin<List<CategoryModel>> {
  List<CategoryModel> categoryList = <CategoryModel>[].obs;
  var selectedCat = 0.obs;
  late CategoryDbHelper _dbHelper;

  static Color getCategoryColors(CATEGORY_COLORS color) {
    switch (color) {
      case CATEGORY_COLORS.teal:
        return Colors.teal;
      case CATEGORY_COLORS.orange:
        return Colors.orange;
      case CATEGORY_COLORS.green:
        return Colors.green;
      case CATEGORY_COLORS.blueGrey:
        return Colors.blueGrey;
      case CATEGORY_COLORS.blue:
        return Colors.blue;
      case CATEGORY_COLORS.brown:
        return Colors.brown;
      default:
        break;
    }
    return Colors.white;
  }

  static String getCategoryNames(DEFAULT_CAT_NAMES cat) {
    switch (cat) {
      case DEFAULT_CAT_NAMES.all:
        return "All";
      case DEFAULT_CAT_NAMES.personal:
        return "Personal";
      case DEFAULT_CAT_NAMES.work:
        return "Work";
      case DEFAULT_CAT_NAMES.entertainment:
        return "Entertainment";
      case DEFAULT_CAT_NAMES.study:
        return "Study";
      case DEFAULT_CAT_NAMES.poem:
        return "Poem";
      default:
        break;
    }
    return "";
  }

  void fillCategoryList() async {
    _dbHelper = CategoryDbHelper.instance;
    final List<CategoryModel> cat = List.generate(
      6,
      (index) => CategoryModel(
          name: getCategoryNames(DEFAULT_CAT_NAMES.values[index]),
          color: index),
    );
    for (var c in cat) {
      _dbHelper.insertCategory(c);
    }
    categoryList = cat;
  }

  int get categoryListLength => categoryList.length;

  set selectedCatIndex(int index) => selectedCat.value = index;

  Future<void> getAllCategories() async {
    _dbHelper = CategoryDbHelper.instance;
    try {
      await _dbHelper.getAllCategories().then((value) {
        categoryList = value;
        if (foundation.kDebugMode) {
          // print("CATEGORY LIST : \n");
          for (var category in categoryList) {
            print(category.name);
          }
        }
        if (categoryList.isNotEmpty) {
          change(categoryList, status: RxStatus.success());
        } else {
          fillCategoryList();
          change([], status: RxStatus.empty());
        }
      });
    } catch (error) {
      change(null, status: RxStatus.error('Something went wrong'));
    }
  }

  addCategory(CategoryModel category) {
    _dbHelper = CategoryDbHelper.instance;
    categoryList.add(category);
    _dbHelper.insertCategory(category);
  }

  getCategoryById(String id) {
    CategoryModel cat = categoryList.singleWhere((c) => c.id == id);
    return cat;
  }

  bool checkCategory(CategoryModel category) {
    int index = categoryList.indexWhere(
        (cat) => cat.name!.toLowerCase() == category.name!.toLowerCase());
    return index == -1 ? false : true;
  }

  removeCategory(String id) {
    categoryList.removeWhere((category) => category.id == id);
  }
}
