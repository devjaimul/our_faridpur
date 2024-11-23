import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_faridpur/utlis/custom_text_button.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';

class DonorCreateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();

  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  DonorCreateScreen({super.key});

  void saveDonor() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final address = addressController.text.trim();
    final phone = phoneController.text.trim();
    final bloodGroup = bloodGroupController.text.trim();

    try {
      await FirebaseFirestore.instance.collection('donor').add({
        'name': name,
        'address': address,
        'phone': phone,
        'bloodGroup': bloodGroup,
      });
      Get.back();
      // Show success snackbar but DO NOT navigate back
      Get.snackbar(
        'সফল',
        'রক্তদাতা সফলভাবে যুক্ত হয়েছে।',

      );

      // Optionally clear the form for new input
      nameController.clear();
      addressController.clear();
      phoneController.clear();
      bloodGroupController.clear();
    } catch (e) {
      Get.snackbar(
        'ত্রুটি',
        'রক্তদাতা সংরক্ষণ করতে ব্যর্থ।',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  void showBloodGroupPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('রক্তের গ্রুপ নির্বাচন করুন'),
          content: SingleChildScrollView(
            child: Column(
              children: bloodGroups.map((group) {
                return ListTile(
                  title: Text(group),
                  onTap: () {
                    bloodGroupController.text = group;
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: 'নতুন রক্তদাতা',color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeHeight*.016),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: sizeHeight*.1),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'নাম'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'অনুগ্রহ করে নাম লিখুন।';
                    }
                    return null;
                  },
                ),
                SizedBox(height: sizeHeight*.016),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'ঠিকানা'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'অনুগ্রহ করে ঠিকানা লিখুন।';
                    }
                    return null;
                  },
                ),
                SizedBox(height: sizeHeight*.016),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'মোবাইল নম্বর'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'অনুগ্রহ করে মোবাইল নম্বর লিখুন।';
                    } else if (!RegExp(r'^\d{11,14}$').hasMatch(value)) {
                      return 'একটি সঠিক মোবাইল নম্বর দিন।';
                    }
                    return null;
                  },
                ),
                SizedBox(height: sizeHeight*.016),
                GestureDetector(
                  onTap: () => showBloodGroupPopup(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: bloodGroupController,
                      decoration: const InputDecoration(
                        labelText: 'রক্তের গ্রুপ',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'অনুগ্রহ করে রক্তের গ্রুপ নির্বাচন করুন।';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: sizeHeight*.2),
                CustomTextButton(
                  text: 'সংরক্ষণ করুন',
                  onTap: saveDonor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
