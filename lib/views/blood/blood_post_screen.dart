import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:our_faridpur/views/blood/blood_create_post_screen.dart';

class BloodPostScreen extends StatelessWidget {
  const BloodPostScreen({super.key});

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

              // Retrieve data or leave blank if not present
              final patientProblem = data['patientProblem'] ?? "";
              final bloodGroup = data['bloodGroup'] ?? "";
              final bloodQuantity = data['bloodQuantity'] ?? "";
              final hemoglobinLevel = data['hemoglobinLevel'] ?? "";
              final donationTime = data['donationTime'] ?? "";
              final donationPlace = data['donationPlace'] ?? "";
              final contact = data['contact'] ?? "";

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
                      HeadingTwo(data: "💁 রোগীর সমস্যা: ${patientProblem.isNotEmpty ? patientProblem : "N/A"}"),
                      HeadingThree(data: "🔴 রক্তের গ্রুপ: ${bloodGroup.isNotEmpty ? bloodGroup : "N/A"}"),
                      HeadingThree(data: "💉 রক্তের পরিমাণ: ${bloodQuantity.isNotEmpty ? bloodQuantity : "N/A"}"),
                      HeadingThree(data: "💊 হিমোগ্লোবিনের: ${hemoglobinLevel.isNotEmpty ? hemoglobinLevel : "N/A"}"),
                      HeadingThree(data: "⌚ রক্তদানের সময়: ${donationTime.isNotEmpty ? donationTime : "N/A"}"),
                      HeadingThree(data: "🏥 রক্তদানের স্থান: ${donationPlace.isNotEmpty ? donationPlace : "N/A"}"),
                      HeadingThree(data: "☎ যোগাযোগ: ${contact.isNotEmpty ? contact : "N/A"}"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Edit Button
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditDialog(context, post.id, data);
                            },
                          ),
                          // Delete Button
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deletePost(post.id);
                            },
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
      floatingActionButton: FloatingActionButton(onPressed: (){Get.to(BloodCreatePostScreen());},child: Icon(Icons.add),),
    );
  }

  // Delete Post Functionality
  void _deletePost(String postId) {
    FirebaseFirestore.instance.collection('blood').doc(postId).delete();
  }

  // Edit Post Dialog
  void _showEditDialog(BuildContext context, String postId, Map<String, dynamic> data) {
    final TextEditingController patientProblemController =
    TextEditingController(text: data['patientProblem'] ?? "");
    final TextEditingController bloodGroupController =
    TextEditingController(text: data['bloodGroup'] ?? "");
    final TextEditingController bloodQuantityController =
    TextEditingController(text: data['bloodQuantity'] ?? "");
    final TextEditingController hemoglobinLevelController =
    TextEditingController(text: data['hemoglobinLevel'] ?? "");
    final TextEditingController donationTimeController =
    TextEditingController(text: data['donationTime'] ?? "");
    final TextEditingController donationPlaceController =
    TextEditingController(text: data['donationPlace'] ?? "");
    final TextEditingController contactController =
    TextEditingController(text: data['contact'] ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Post"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField("Patient Problem", patientProblemController),
              _buildTextField("Blood Group", bloodGroupController),
              _buildTextField("Blood Quantity", bloodQuantityController),
              _buildTextField("Hemoglobin Level", hemoglobinLevelController),
              _buildTextField("Donation Time", donationTimeController),
              _buildTextField("Donation Place", donationPlaceController),
              _buildTextField("Contact", contactController),
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
              // Update Firestore Document
              FirebaseFirestore.instance.collection('blood').doc(postId).update({
                'patientProblem': patientProblemController.text,
                'bloodGroup': bloodGroupController.text,
                'bloodQuantity': bloodQuantityController.text,
                'hemoglobinLevel': hemoglobinLevelController.text,
                'donationTime': donationTimeController.text,
                'donationPlace': donationPlaceController.text,
                'contact': contactController.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // Helper Widget to Build TextField
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
