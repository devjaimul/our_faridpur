import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/utlis/custom_text_button.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';

class BloodCreatePostScreen extends StatelessWidget {
  const BloodCreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final sizeWidth = MediaQuery.sizeOf(context).width;

    final TextEditingController patientProblemController =
    TextEditingController();
    final TextEditingController bloodGroupController =
    TextEditingController();
    final TextEditingController bloodQuantityController =
    TextEditingController();
    final TextEditingController hemoglobinLevelController =
    TextEditingController();
    final TextEditingController donationTimeController =
    TextEditingController();
    final TextEditingController donationPlaceController =
    TextEditingController();
    final TextEditingController contactController = TextEditingController();

    Future<void> _submitPost() async {
      if (bloodGroupController.text.isEmpty ||
          bloodQuantityController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields.')),
        );
        return;
      }

      final data = {
        "patientProblem": patientProblemController.text,
        "bloodGroup": bloodGroupController.text,
        "bloodQuantity": bloodQuantityController.text,
        "hemoglobinLevel": hemoglobinLevelController.text,
        "donationTime": donationTimeController.text,
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

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: "Create Blood Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeWidth * 0.05,),
          child: Column(
            children: [
              TextField(
                controller: patientProblemController,
                decoration: const InputDecoration(labelText: "💁রোগীর সমস্যা:-"),
              ),
              SizedBox(height: sizeHeight * 0.02),
              TextField(
                controller: bloodGroupController,
                decoration: const InputDecoration(labelText: "🔴রক্তের গ্রুপ:-"),
              ),
              SizedBox(height: sizeHeight * 0.02),
              TextField(
                controller: bloodQuantityController,
                decoration: const InputDecoration(labelText: "💉রক্তের পরিমাণ:-"),
              ),
              SizedBox(height: sizeHeight * 0.02),
              TextField(
                controller: hemoglobinLevelController,
                decoration: const InputDecoration(labelText: "💊হিমোগ্লোবিনের:-"),
              ),
              SizedBox(height: sizeHeight * 0.02),
              TextField(
                controller: donationTimeController,
                decoration: const InputDecoration(labelText: "⌚রক্তদানের সময়:-"),
              ),
              SizedBox(height: sizeHeight * 0.02),
              TextField(
                controller: donationPlaceController,
                decoration: const InputDecoration(labelText: "🏥রক্তদানের স্থান:-"),
              ),
              SizedBox(height: sizeHeight * 0.02),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(labelText: "☎যোগাযোগ :"),
              ),
              SizedBox(height: sizeHeight * 0.05),
             CustomTextButton(text: 'Submit', onTap: (){
               _submitPost();
               Get.back();
             })
            ],
          ),
        ),
      ),
    );
  }
}
