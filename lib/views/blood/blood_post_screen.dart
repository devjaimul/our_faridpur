import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/controller/blood_post_screen.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:our_faridpur/views/blood/blood_create_post_screen.dart';

class BloodPostScreen extends StatelessWidget {
  BloodPostScreen({super.key});

  final controller = Get.put(BloodPostScreenController());

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final sizeWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const HeadingTwo(data: "Blood Posts"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("blood").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No posts available."));
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
                      HeadingTwo(data: "💁 রোগীর সমস্যা: ${data['patientProblem'] ?? "N/A"}"),
                      HeadingThree(data: "🔴 রক্তের গ্রুপ: ${data['bloodGroup'] ?? "N/A"}"),
                      HeadingThree(data: "💉 রক্তের পরিমাণ: ${data['bloodQuantity'] ?? "N/A"}"),
                      HeadingThree(data: "💊 হিমোগ্লোবিনের: ${data['hemoglobinLevel'] ?? "N/A"}"),
                      HeadingThree(data: "⌚ রক্তদানের সময়: ${data['donationTime'] ?? "N/A"}"),
                      HeadingThree(data: "📅 রক্তদানের তারিখ: ${data['donationDate'] ?? "N/A"}"),
                      HeadingThree(data: "🏥 রক্তদানের স্থান: ${data['donationPlace'] ?? "N/A"}"),
                      HeadingThree(data: "☎ যোগাযোগ: ${data['contact'] ?? "N/A"}"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditDialog(context, post.id, data),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.deletePost(post.id),
                          ),
                        ],
                      ),
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
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String postId, Map<String, dynamic> data) {
    controller.initializeControllers(data);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Post"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField("Patient Problem", controller.patientProblemController),
              _buildPopupMenuField("Blood Group", controller.bloodGroupController),
              _buildTextField("Blood Quantity", controller.bloodQuantityController),
              _buildTextField("Hemoglobin Level", controller.hemoglobinLevelController),
              _buildDateTimePicker(context, "Donation Time", controller.donationTimeController, isTimePicker: true),
              _buildDateTimePicker(context, "Donation Date", controller.donationDateController, isTimePicker: false),
              _buildTextField("Donation Place", controller.donationPlaceController),
              _buildTextField("Contact", controller.contactController),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.updatePost(postId);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            icon: Icon(isTimePicker ? Icons.access_time : Icons.calendar_today),
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
