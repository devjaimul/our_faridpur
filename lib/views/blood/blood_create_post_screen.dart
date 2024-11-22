import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/controller/blood_create_post_screen.dart';
import 'package:our_faridpur/utlis/custom_text_button.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';

class BloodCreatePostScreen extends StatelessWidget {
  const BloodCreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BloodCreatePostScreenController());
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final sizeWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar:AppBar(title: const HeadingTwo(data: "ব্লাড পোস্ট তৈরি করুন",color: Colors.white,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sizeWidth * 0.05),
          child: Column(
            children: [
              _buildValidatedTextField(
                label: "রোগীর সমস্যা",
                controller: controller.patientProblemController,
                keyboardType: TextInputType.text,
                errorText: controller.patientProblemError,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildBloodGroupField(context, controller),
              SizedBox(height: sizeHeight * 0.02),
              _buildValidatedTextField(
                label: "রক্তের পরিমাণ ",
                controller: controller.bloodQuantityController,
                keyboardType: TextInputType.number,
                errorText: controller.bloodQuantityError,
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
                errorText: controller.donationTimeError,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildDateTimePicker(
                context: context,
                label: "রক্তদানের তারিখ ",
                controller: controller.donationDateController,
                isTimePicker: false,
                errorText: controller.donationDateError,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildValidatedTextField(
                label: "রক্তদানের স্থান ",
                controller: controller.donationPlaceController,
                keyboardType: TextInputType.text,
                errorText: controller.donationPlaceError,
              ),
              SizedBox(height: sizeHeight * 0.02),
              _buildValidatedTextField(
                label: "যোগাযোগ ",
                controller: controller.contactController,
                keyboardType: TextInputType.phone,
                errorText: controller.contactError,
              ),
              SizedBox(height: sizeHeight * 0.05),
              CustomTextButton(
                text: 'Submit',
                onTap: () {
                  if (controller.validateForm()) {
                    controller.submitPost(context);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidatedTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required RxString errorText,
  }) {
    return Obx(
          () => TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText.isEmpty ? null : errorText.value,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'এটি খালি হতে পারে না';
          }
          return null;
        },
      ),
    );
  }


  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty.';
        }
        return null;
      },
    );
  }


  Widget _buildBloodGroupField(
      BuildContext context, BloodCreatePostScreenController controller) {
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
          () => TextFormField(
        controller: TextEditingController(text: controller.bloodGroup.value),
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: "রক্তের গ্রুপ",
          errorText: controller.bloodGroupError.value.isEmpty
              ? null
              : controller.bloodGroupError.value,
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down),
            onSelected: (value) {
              controller.bloodGroup.value = value;
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
        onTap: () {
          showMenu(
            context: context,
            position: const RelativeRect.fromLTRB(100, 100, 100, 100),
            items: bloodGroups.map((group) {
              return PopupMenuItem(
                value: group,
                child: Text(group),
                onTap: () {
                  controller.bloodGroup.value = group;
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildDateTimePicker({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required bool isTimePicker,
    required RxString errorText,
  }) {
    return Obx(
          () => TextFormField(
        controller: controller,
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText.isEmpty ? null : errorText.value,
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
        onTap: () async {
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return isTimePicker
                ? 'Please select a valid time.'
                : 'Please select a valid date.';
          }
          return null;
        },
      ),
    );
  }



}
