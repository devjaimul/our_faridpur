import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/controller/blood_post_screen_controller.dart';
import 'package:our_faridpur/utlis/app_colors.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:our_faridpur/views/blood/post/blood_create_post_screen.dart';
import 'package:our_faridpur/widgets/dialog.dart';
import 'package:url_launcher/url_launcher.dart';


class BloodPostScreen extends StatelessWidget {
  BloodPostScreen({super.key});

  final controller = Get.put(BloodPostScreenController());
  // Function to launch the dialer with cleaned phone number
  Future<void> _launchDialer(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), ''); // Remove non-numeric characters
    final Uri url = Uri.parse('tel:$cleanNumber');

    if (await launchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final sizeWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("blood").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: HeadingThree(data: "এই মুহূর্তে কোন পোস্ট নেই।"));
          }

          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final data = post.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: sizeWidth * 0.05,
                  vertical: sizeHeight * 0.01,
                ),
                child: Padding(
                  padding: EdgeInsets.all(sizeWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingThree(data: "🩸 রক্তের গ্রুপ: ${data['bloodGroup'] ?? "N/A"}",color: Colors.black,fontWeight: FontWeight.w600,fontSize: sizeHeight * 0.022,),

                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert_outlined),
                            onSelected: (value) {
                              if (value == 'Edit') {
                                _showEditDialog(context, post.id, data);
                              } else if (value == 'Delete') {
                                _showDeleteDialog(context, post.id);
                              }
                              else if (value == 'call') {
                                final contact = data['contact'] ?? "";
                                if (contact.isNotEmpty) {
                                  _launchDialer(contact);
                                } else {
                                  Get.snackbar('Error', 'Contact number not available');
                                }
                              }
                            },
                            itemBuilder: (context) => [
                               PopupMenuItem(
                                value: 'Edit',
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit,color: AppColors.primaryColor,),
                                    SizedBox(width: 8.w),
                                    const Text('এডিট'),
                                  ],
                                ),
                              ),
                               PopupMenuItem(
                                value: 'Delete',
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8.w),
                                    const Text('ডিলিট'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'call',
                                child: Row(
                                  children: [
                                    const Icon(Icons.phone, color: AppColors.primaryColor),
                                    SizedBox(width: 8.w),
                                    const Text('Call'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      HeadingThree(data: "💁 রোগীর সমস্যা: ${data['patientProblem'] ?? "N/A"}"),
                      HeadingThree(data: "💉 রক্তের পরিমাণ: ${data['bloodQuantity'] ?? "N/A"}"),
                      HeadingThree(data: "💊 হিমোগ্লোবিনের পরিমাণ: ${data['hemoglobinLevel'] ?? "N/A"}"),
                      HeadingThree(data: "🏥 রক্তদানের স্থান: ${data['donationPlace'] ?? "N/A"}"),
                      HeadingThree(data: "☎ যোগাযোগ: ${data['contact'] ?? "N/A"}"),
                      HeadingThree(data: "⌚ রক্তদানের সময়: ${data['donationTime'] ?? "N/A"}"),
                      HeadingThree(data: "📅 রক্তদানের তারিখ: ${data['donationDate'] ?? "N/A"}",color: AppColors.primaryColor,fontWeight: FontWeight.w700,),
                    ],
                  ),
                ),
              );

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Get.to(() => const BloodCreatePostScreen());
        },
        child: const Icon(Icons.add,),
      ),
    );
  }

  // Function to show delete confirmation dialog
  void _showDeleteDialog(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'আপনি কি এই পোস্টটি মুছতে চান?',
        cancelButtonText: 'না',
        confirmButtonText: 'হ্যাঁ, মুছুন',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          controller.deletePost(postId);
          Navigator.pop(context); // Close the dialog
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, String postId, Map<String, dynamic> data) {
    controller.initializeControllers(data);

    showDialog(
      context: context,
      builder: (context) {
        // Get the width of the screen
        final sizeWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          title: const Center(child: HeadingTwo(data: 'এডিট পোস্ট')),
          content: SizedBox(
            width: sizeWidth * 0.85,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField("রোগীর সমস্যা", controller.patientProblemController),
                  _buildPopupMenuField("রক্তের গ্রুপ", controller.bloodGroupController),
                  _buildTextField("রক্তের পরিমাণ", controller.bloodQuantityController),
                  _buildTextField("হিমোগ্লোবিনের পরিমাণ", controller.hemoglobinLevelController),
                  _buildDateTimePicker(context, "রক্তদানের সময়", controller.donationTimeController, isTimePicker: true),
                  _buildDateTimePicker(context, "রক্তদানের তারিখ", controller.donationDateController, isTimePicker: false),
                  _buildTextField("রক্তদানের স্থান", controller.donationPlaceController),
                  _buildTextField("যোগাযোগ", controller.contactController),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const HeadingThree(data: 'বাতিল'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.updatePost(postId);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                        child: const HeadingThree(data: 'সেভ', color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPopupMenuField(String label, TextEditingController controller) {
    final bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down),
            onSelected: (value) => controller.text = value,
            itemBuilder: (context) {
              return bloodGroups
                  .map((group) => PopupMenuItem(value: group, child: Text(group)))
                  .toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context, String label, TextEditingController controller, {required bool isTimePicker}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(isTimePicker ? Icons.access_time : Icons.calendar_month),
            onPressed: () async {
              if (isTimePicker) {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  controller.text = pickedTime.format(context);
                }
              } else {
                final pickedDate = await showDatePicker(
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
      ),
    );
  }
}
