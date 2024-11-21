import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/controller/blood_create_post_screen.dart';
import 'package:our_faridpur/utlis/custom_text_button.dart';


class BloodCreatePostScreen extends StatelessWidget {
  const BloodCreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BloodCreatePostScreenController());
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final sizeWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Blood Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeWidth * 0.05),
          child: Column(
            children: [
              _buildTextField(
                label: "রোগীর সমস্যা",
                controller: controller.patientProblemController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildBloodGroupField(context, controller),
              SizedBox(height: sizeHeight * 0.02),
              _buildTextField(
                label: "রক্তের পরিমাণ ",
                controller: controller.bloodQuantityController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildTextField(
                label: "হিমোগ্লোবিনের পরিমাণ",
                controller: controller.hemoglobinLevelController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildDateTimePicker(
                context: context,
                label: "রক্তদানের সময় ",
                controller: controller.donationTimeController,
                isTimePicker: true,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildDateTimePicker(
                context: context,
                label: "রক্তদানের তারিখ ",
                controller: controller.donationDateController,
                isTimePicker: false,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildTextField(
                label: "রক্তদানের স্থান ",
                controller: controller.donationPlaceController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildTextField(
                label: "যোগাযোগ ",
                controller: controller.contactController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: sizeHeight * 0.05),
              CustomTextButton(
                text: 'Submit',
                onTap: () {
                  controller.submitPost(context);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
    );
  }
  Widget _buildBloodGroupField(BuildContext context, BloodCreatePostScreenController controller) {
    final bloodGroups = [
      "A+",
      "A-",
      "B+",
      "B-",
      "AB+",
      "AB-",
      "O+",
      "O-",
    ];

    return Obx(
          () => TextField(
        controller: TextEditingController(text: controller.bloodGroup.value), // Display the selected value
        readOnly: true, // Make it read-only
        decoration: InputDecoration(
          labelText: "রক্তের গ্রুপ",
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
            onSelected: (value) {
              controller.bloodGroup.value = value; // Update the selected value
            },
            itemBuilder: (context) {
              return bloodGroups.map((group) {
                return PopupMenuItem(
                  value: group,
                  child: Text(group),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }



  Widget _buildDateTimePicker({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required bool isTimePicker,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(isTimePicker ? Icons.access_time : Icons.calendar_today),
          onPressed: () async {
            if (isTimePicker) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                controller.text = pickedTime.format(context);
              }
            } else {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                controller.text =
                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
              }
            }
          },
        ),
      ),
    );
  }
}
