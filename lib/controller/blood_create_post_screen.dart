import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodCreatePostScreenController extends GetxController {
  final patientProblemController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final bloodGroup = ''.obs; // Use RxString for blood group
  final bloodQuantityController = TextEditingController();
  final hemoglobinLevelController = TextEditingController();
  final donationTimeController = TextEditingController();
  final donationDateController = TextEditingController();
  final donationPlaceController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    patientProblemController.dispose();
    bloodGroupController.dispose();
    bloodQuantityController.dispose();
    hemoglobinLevelController.dispose();
    donationTimeController.dispose();
    donationDateController.dispose();
    donationPlaceController.dispose();
    contactController.dispose();
    super.onClose();
  }

  Future<void> submitPost(BuildContext context) async {
    if (bloodGroup.value.isEmpty || bloodQuantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    final data = {
      "patientProblem": patientProblemController.text,
      "bloodGroup": bloodGroup.value, // Use the reactive blood group value
      "bloodQuantity": bloodQuantityController.text,
      "hemoglobinLevel": hemoglobinLevelController.text,
      "donationTime": donationTimeController.text,
      "donationDate": donationDateController.text,
      "donationPlace": donationPlaceController.text,
      "contact": contactController.text,
    };

    try {
      await FirebaseFirestore.instance.collection("blood").add(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

