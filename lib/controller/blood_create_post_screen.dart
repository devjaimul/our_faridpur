import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodCreatePostScreenController extends GetxController {
  final patientProblemController = TextEditingController();
  final bloodGroup = ''.obs;
  final bloodQuantityController = TextEditingController();
  final hemoglobinLevelController = TextEditingController();
  final donationTimeController = TextEditingController();
  final donationDateController = TextEditingController();
  final donationPlaceController = TextEditingController();
  final contactController = TextEditingController();

  // Validation error messages
  final patientProblemError = ''.obs;
  final bloodGroupError = ''.obs;
  final bloodQuantityError = ''.obs;
  final donationPlaceError = ''.obs;
  final contactError = ''.obs;
  final donationTimeError = ''.obs;
  final donationDateError = ''.obs;

  @override
  void onClose() {
    patientProblemController.dispose();
    bloodQuantityController.dispose();
    hemoglobinLevelController.dispose();
    donationTimeController.dispose();
    donationDateController.dispose();
    donationPlaceController.dispose();
    contactController.dispose();
    super.onClose();
  }

  bool validateForm() {
    bool isValid = true;

    if (patientProblemController.text.isEmpty) {
      patientProblemError.value = 'রোগীর সমস্যার তথ্য দিন।';
      isValid = false;
    } else {
      patientProblemError.value = '';
    }

    if (bloodGroup.value.isEmpty) {
      bloodGroupError.value = 'রক্তের গ্রুপ নির্বাচন করুন।';
      isValid = false;
    } else {
      bloodGroupError.value = '';
    }

    if (bloodQuantityController.text.isEmpty) {
      bloodQuantityError.value = 'রক্তের পরিমাণ লিখুন।';
      isValid = false;
    } else {
      bloodQuantityError.value = '';
    }

    if (donationPlaceController.text.isEmpty) {
      donationPlaceError.value = 'রক্তদানের স্থানের তথ্য দিন।';
      isValid = false;
    } else {
      donationPlaceError.value = '';
    }

    if (contactController.text.isEmpty) {
      contactError.value = 'যোগাযোগের নম্বর দিন।';
      isValid = false;
    } else {
      contactError.value = '';
    }

    if (donationTimeController.text.isEmpty) {
      donationTimeError.value = 'রক্তদানের সময় নির্বাচন করুন।';
      isValid = false;
    } else {
      donationTimeError.value = '';
    }

    if (donationDateController.text.isEmpty) {
      donationDateError.value = 'রক্তদানের তারিখ নির্বাচন করুন।';
      isValid = false;
    } else {
      donationDateError.value = '';
    }

    return isValid;
  }

  Future<void> submitPost(BuildContext context) async {
    if (!validateForm()) {
      return;
    }

    final data = {
      "patientProblem": patientProblemController.text,
      "bloodGroup": bloodGroup.value,
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


