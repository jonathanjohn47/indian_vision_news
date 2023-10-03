import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indian_vision_news/core/app_constants.dart';

import '../../../models/category_model.dart';

class HomePageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<ArticleCategoryModel> categories = <ArticleCategoryModel>[].obs;

  RxInt selectedIndex = 0.obs;

  late TabController tabController;

  void loadCategories() async {
    FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .snapshots()
        .listen((value) {
      categories.value = value.docs
          .map((e) =>
              ArticleCategoryModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
      categories.sort((a, b) => a.categoryNumber.compareTo(b.categoryNumber));
      tabController = TabController(length: categories.length, vsync: this);
      tabController.addListener(() {
        selectedIndex.value = tabController.index;
      });
    });
  }

  @override
  void onInit() {
    loadCategories();
    super.onInit();
  }

  Future<void> deleteDuplicateCategories() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.categories)
        .get()
        .then((value) async {
      List<ArticleCategoryModel> allCategories = value.docs
          .map((e) =>
              ArticleCategoryModel.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
      List<ArticleCategoryModel> uniqueCategories = [];
      for (var category in allCategories) {
        int indexWhere = uniqueCategories.indexWhere((uniqueCategory) {
          return uniqueCategory.name == category.name;
        });
        if (indexWhere == -1) {
          uniqueCategories.add(category);
        }
      }
      for (var allCategory in allCategories) {
        await FirebaseFirestore.instance
            .collection(AppConstants.categories)
            .doc(allCategory.id)
            .delete();
      }
      for (var uniqueCategory in uniqueCategories) {
        ArticleCategoryModel newCategory = uniqueCategory.copyWith(
            id: '${uniqueCategories.indexOf(uniqueCategory) + 1}',
            categoryNumber: uniqueCategories.indexOf(uniqueCategory) + 1);
        await FirebaseFirestore.instance
            .collection(AppConstants.categories)
            .doc(newCategory.id)
            .set(newCategory.toJson());
      }
    });
  }

  Future<void> saveCategory() async {
    List<String> categoryNames = [];

    //$\begin{array}{llllll}\text { JAMMU } & \text { KASHMIR NATIONAL EDIT/OPINION EDUCATION ENTERTAINMENT HEALTHCARE WORLD BUSINESS SPORTS }\end{array}$

    categoryNames.addAll([
      'Jammu',
      'Kashmir',
      'National',
      'Edit/opinion',
      'Education',
      'Entertainment',
      'Healthcare',
      'World',
      'Business',
      'Sports'
    ]);

    for (var categoryName in categoryNames) {
      ArticleCategoryModel articleCategoryModel = ArticleCategoryModel(
          id: (categories.length + 1).toString(),
          name: categoryName,
          categoryNumber: categories.length + 1,
          requiresRegistration: false);

      await FirebaseFirestore.instance
          .collection(AppConstants.categories)
          .doc((categories.length + 1).toString())
          .set(articleCategoryModel.toJson());
    }
  }
}
