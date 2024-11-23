import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:our_faridpur/utlis/app_colors.dart';
import 'package:our_faridpur/utlis/app_icons.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:our_faridpur/views/blood/donar/donor_create_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorListScreen extends StatefulWidget {
  const DonorListScreen({super.key});

  @override
  State<DonorListScreen> createState() => _DonorListScreenState();
}

class _DonorListScreenState extends State<DonorListScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

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

      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW * .04, vertical: sizeH * .015),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'নাম, রক্তের গ্রুপ বা ঠিকানা দ্বারা অনুসন্ধান করুন',
                prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('donor').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('কোনো রক্তদাতা নেই।'));
                }

                final donors = snapshot.data!.docs.where((donor) {
                  final name = donor['name'].toString().toLowerCase();
                  final bloodGroup = donor['bloodGroup'].toString().toLowerCase();
                  final address = donor['address'].toString().toLowerCase();

                  return name.contains(searchQuery) ||
                      bloodGroup.contains(searchQuery) ||
                      address.contains(searchQuery);
                }).toList();

                if (donors.isEmpty) {
                  return const Center(child: Text('কোনো মিল নেই।'));
                }

                return ListView.builder(
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    final donor = donors[index];
                    final name = donor['name'] ?? 'Unknown';
                    final bloodGroup = donor['bloodGroup'] ?? 'Unknown';
                    final address = donor['address'] ?? 'Unknown';
                    final phone = donor['phone'] ?? 'Unknown';

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizeH * .016, vertical: sizeH * .002),
                      child: Card(
                        color: AppColors.cardColor.withOpacity(0.8),
                        child: ListTile(
                          title: HeadingThree(
                            data: name,
                            color: Colors.green,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingThree(
                                data: 'রক্তের গ্রুপ: $bloodGroup',
                                fontWeight: FontWeight.w600,
                              ),
                              HeadingThree(data: 'ঠিকানা: $address'),
                              HeadingThree(
                                data: 'যোগাযোগ: $phone',
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon:  Lottie.asset(AppIcons.phone, height: sizeH * .08),
                            onPressed: () {
                              _launchDialer(phone);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => DonorCreateScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
