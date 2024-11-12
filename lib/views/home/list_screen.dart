import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final String category;

  ListScreen({required this.category});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category List'),
        backgroundColor: Colors.blue, // Replace with your color
      ),
      body: FutureBuilder<DocumentSnapshot>(
        // Directly get the document
        future: _firestore.collection('faridpur').doc(category.toLowerCase()).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data available'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          // Create a list from the fields
          final items = data.entries.toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final entry = items[index];
              final hospitalData = entry.value as Map<String, dynamic>; // Cast the value as Map

              return Card(
                child: ListTile(
                  title: Text(hospitalData['name'] ?? 'Unknown'),
                  subtitle: Text(hospitalData['address'] ?? 'No address'),
                  trailing: Text(hospitalData['phone'] ?? 'No phone'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

