import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:our_faridpur/controller/list_controller.dart';
import 'package:our_faridpur/utlis/app_colors.dart';
import 'package:our_faridpur/utlis/app_icons.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ListScreen extends StatefulWidget {
  final String category;

  const ListScreen({super.key, required this.category});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ListController _controller = Get.put(ListController());

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
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: HeadingTwo(data: widget.category, color: Colors.white),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('faridpur').doc(widget.category.toLowerCase()).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final allItems = data.entries.toList();
          _controller.setAllItems(allItems);

          return Column(
            children: [
              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeW * .04, vertical: sizeH * .015),
                child: TextField(
                  controller: _controller.searchController,
                  decoration: InputDecoration(
                    hintText: 'নাম, ঠিকানা বা নম্বর দ্বারা অনুসন্ধান করুন',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onChanged: (value) {
                    _controller.searchQuery.value = value;
                    _controller.updateFilteredItems();
                  },
                ),
              ),
              // List of filtered items
              Expanded(
                child: Obx(() {
                  // If no filtered items match the search, show the Lottie animation
                  if (_controller.filteredItems.isEmpty) {
                    return Center(
                      child: Lottie.asset(
                        AppIcons.nothing, // Path to your Lottie asset
                      // Responsive width
                        height: sizeH * 0.3, // Responsive height
                        fit: BoxFit.cover,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: _controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      final entry = _controller.filteredItems[index];
                      final categoriesData = entry.value as Map<String, dynamic>;

                      // Handle phone numbers for display and dialer
                      final phoneData = categoriesData['phone'];
                      final phoneNumbers = (phoneData != null && phoneData is List)
                          ? phoneData.join(', ')
                          : (phoneData != null ? phoneData.toString() : "");

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: sizeH * .016, vertical: sizeH * .002),
                        child: Card(
                          color: AppColors.cardColor.withOpacity(0.8),
                          elevation: 2,
                          child: ListTile(
                            title: HeadingThree(
                              data: categoriesData['name'] ?? 'Unknown',
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display the address only if it is not empty or null
                                if (categoriesData['address'] != null && categoriesData['address'].toString().isNotEmpty)
                                  HeadingThree(
                                    data: "${categoriesData['address']}",
                                    fontSize: sizeH * .016,
                                    color: AppColors.textColor.withOpacity(0.6),
                                  ),
                                SizedBox(height: sizeH * .005),
                                // Display the phone number only if it is not empty or null
                                if (phoneNumbers.isNotEmpty)
                                  HeadingThree(
                                    data: "যোগাযোগ : $phoneNumbers",
                                    fontSize: sizeH * .016,
                                  ),
                              ],
                            ),
                            trailing: (phoneNumbers.isNotEmpty) // Only show the Lottie icon if phone number exists
                                ? GestureDetector(
                              onTap: () async {
                                final numberToDial = phoneData is List ? phoneData[0] : phoneData;
                                if (numberToDial != null) {
                                  _launchDialer(numberToDial);
                                }
                              },
                              child: Lottie.asset(AppIcons.phone, height: sizeH * .08),
                            )
                                : null, // Don't show anything if phone number is empty
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
