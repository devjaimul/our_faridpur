import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BloodPostScreenController extends GetxController {
  final TextEditingController patientProblemController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController bloodQuantityController = TextEditingController();
  final TextEditingController hemoglobinLevelController = TextEditingController();
  final TextEditingController donationTimeController = TextEditingController();
  final TextEditingController donationDateController = TextEditingController();
  final TextEditingController donationPlaceController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  void initializeControllers(Map<String, dynamic> data) {
    patientProblemController.text = data['patientProblem'] ?? "";
    bloodGroupController.text = data['bloodGroup'] ?? "";
    bloodQuantityController.text = data['bloodQuantity'] ?? "";
    hemoglobinLevelController.text = data['hemoglobinLevel'] ?? "";
    donationTimeController.text = data['donationTime'] ?? "";
    donationDateController.text = data['donationDate'] ?? "";
    donationPlaceController.text = data['donationPlace'] ?? "";
    contactController.text = data['contact'] ?? "";
  }

  void deletePost(String postId) {
    FirebaseFirestore.instance.collection('blood').doc(postId).delete();
  }

  void updatePost(String postId) {
    FirebaseFirestore.instance.collection('blood').doc(postId).update({
      'patientProblem': patientProblemController.text,
      'bloodGroup': bloodGroupController.text,
      'bloodQuantity': bloodQuantityController.text,
      'hemoglobinLevel': hemoglobinLevelController.text,
      'donationTime': donationTimeController.text,
      'donationDate': donationDateController.text,
      'donationPlace': donationPlaceController.text,
      'contact': contactController.text,
    });
  }
}
