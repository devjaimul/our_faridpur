import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ListScreen extends StatelessWidget {
  final String category;

  ListScreen({super.key, required this.category});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('$category List'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('faridpur').doc(category.toLowerCase()).get(),
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
          final items = data.entries.toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final entry = items[index];
              final categoriesData = entry.value as Map<String, dynamic>;

              // Handle phone numbers for display and dialer
              final phoneData = categoriesData['phone'];
              final phoneNumbers = phoneData is List
                  ? phoneData.join(', ')
                  : phoneData.toString();

              return Card(
                child: ListTile(
                  title: Text(categoriesData['name'] ?? 'Unknown'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(categoriesData['address'] ?? 'No address'),
                      SizedBox(height: 10.h),
                      Text(phoneNumbers),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      final numberToDial = phoneData is List ? phoneData[0] : phoneData;
                      if (numberToDial != null) {
                        _launchDialer(numberToDial);
                      }
                    },
                    icon: const Icon(Icons.phone),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
