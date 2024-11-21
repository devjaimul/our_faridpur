import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadCategoriesData() async {
  final firestore = FirebaseFirestore.instance;

  // Define the data with the correct type Map<String, dynamic>
  final List<Map<String, dynamic>> categoriesData =
  [
    {
      "name": "Faridpur HO",
      "address": "Sadar\n (7800)",
      "phone": [""]
    },
    {
      "name": "Kanaipur SO",
      "address": "Sadar\n (7801)",
      "phone": [""]
    },
    {
      "name": "Ambicapur SO",
      "address": "Sadar\n (7802)",
      "phone": [""]
    },
    {
      "name": "Baitul Aman Politechnoque Institute TSO",
      "address": "Sadar\n (7803)",
      "phone": [""]
    },
    {
      "name": "Sree Angan SO",
      "address": "Sadar\n (7804)",
      "phone": [""]
    },
    {
      "name": "Char Bhadrasan UPO",
      "address": "Char Bhadrasan\n (7810)",
      "phone": [""]
    },
    {
      "name": "Sadarpur UPO",
      "address": "Sadarpur\n (7820)",
      "phone": [""]
    },
    {
      "name": "Hatkrishnapur SO",
      "address": "Sadarpur\n (7821)",
      "phone": [""]
    },
    {
      "name": "Biswajaker Manjil SO",
      "address": "Sadarpur\n (7822)",
      "phone": [""]
    },
    {
      "name": "Bhanga UPO",
      "address": "Bhanga\n (7830)",
      "phone": [""]
    },
    {
      "name": "Nagarkanda UPO",
      "address": "Nagarkanda\n (7840)",
      "phone": [""]
    },
    {
      "name": "Talma SO",
      "address": "Nagarkanda\n (7841)",
      "phone": [""]
    },
    {
      "name": "Madhukhali UPO",
      "address": "Madhukhali\n (7850)",
      "phone": [""]
    },
    {
      "name": "Kamarkhali SO",
      "address": "Madhukhali\n (7851)",
      "phone": [""]
    },
    {
      "name": "Boalmari UPO",
      "address": "Boalmari\n (7860)",
      "phone": [""]
    },
    {
      "name": "Rupapat EDSO",
      "address": "Boalmari\n (7861)",
      "phone": [""]
    },
    {
      "name": "Alfadanga UPO",
      "address": "Alfadanga\n (7870)",
      "phone": [""]
    }
  ]



















  ;

  // Adding each categories entry to Firestore under the "faridpur/categories" document
  for (var categories in categoriesData) {
    final categoriesName = categories['name'] as String;
    //change the categories name
    await firestore.collection('faridpur').doc('পোস্ট কোড').set({
      categoriesName: {
        "name": categoriesName,
        "address": categories['address'] ?? "",
        "phone": categories['phone'] ?? [],
      }
    }, SetOptions(merge: true));
  }
}
