
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// Controller to manage search logic
class ListController extends GetxController {
  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxList<MapEntry<String, dynamic>> filteredItems = <MapEntry<String, dynamic>>[].obs;
  List<MapEntry<String, dynamic>> allItems = [];

  void setAllItems(List<MapEntry<String, dynamic>> items) {
    allItems = items;
    updateFilteredItems();
  }

  void updateFilteredItems() {
    final query = searchQuery.value.toLowerCase();
    filteredItems.value = allItems.where((entry) {
      final name = entry.value['name']?.toString().toLowerCase() ?? '';
      final address = entry.value['address']?.toString().toLowerCase() ?? '';
      final phone = entry.value['phone']?.toString().toLowerCase() ?? '';
      return name.contains(query) || address.contains(query) || phone.contains(query);
    }).toList();
  }
}
