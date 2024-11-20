import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadCategoriesData() async {
  final firestore = FirebaseFirestore.instance;

  // Define the data with the correct type Map<String, dynamic>
  final List<Map<String, dynamic>> categoriesData =
  [
    {
      "name": "ফরিদপুর-ভাঙ্গা (সকাল: ৬:৫৮)",
      "address": "রাজবাড়ী এক্সপ্রেস",
      "phone": []
    },
    {
      "name": "ফরিদপুর-খুলনা (দুপুর: ২:১৭)",
      "address": "নক্সিকাথা কমিউটার ট্রেন",
      "phone": []
    },
    {
      "name": "ফরিদপুর-ঢাকা (সকাল: ৭:১৮)",
      "address": "নক্সিকাথা কমিউটার ট্রেন",
      "phone": []
    },
    {
      "name": "ফরিদপুর-রাজবাড়ী (সকাল: ৯:০৮)",
      "address": "রাজবাড়ী এক্সপ্রেস",
      "phone": []
    },
    {
      "name": "ফরিদপুর-খুলনা (সকাল: ১০:০৮)",
      "address": "সুন্দরবন এক্সপ্রেস\nসাপ্তাহিক বন্ধ বুধবার",
      "phone": []
    },
    {
      "name": "ফরিদপুর-ঢাকা (সকাল: ১১:৪০)",
      "address": "মধুমতি এক্সপ্রেস\nসাপ্তাহিক বন্ধ বৃহস্পতিবার",
      "phone": []
    },
    {
      "name": "ফরিদপুর-রাজশাহী (বিকাল: ৫:১৮)",
      "address": "মধুমতি এক্সপ্রেস\nসাপ্তাহিক বন্ধ বৃহস্পতিবার",
      "phone": []
    },
    {
      "name": "ফরিদপুর-ভাঙ্গা (সন্ধ্যা: ০৬:০৫)",
      "address": "রাজবাড়ী এক্সপ্রেস",
      "phone": []
    },
    {
      "name": "ফরিদপুর-ঢাকা (রাত: ০২:৫৭)",
      "address": "সুন্দরবন এক্সপ্রেস\nসাপ্তাহিক বন্ধ বুধবার",
      "phone": []
    },
    {
      "name": "ফরিদপুর-বেনাপোল (রাত: ০১:৩৮)",
      "address": "বেনাপোল এক্সপ্রেস\nসাপ্তাহিক বন্ধ বুধবার",
      "phone": []
    },
    {
      "name": "ফরিদপুর-ঢাকা (সন্ধ্যা: ০৬:৪৫)",
      "address": "벤াপোল এক্সপ্রেস\nসাপ্তাহিক বন্ধ বুধবার",
      "phone": []
    },
    {
      "name": "ফরিদপুর-রাজবাড়ী (রাত: ০৮:২২)",
      "address": "রাজবাড়ী এক্সপ্রেস",
      "phone": []
    },
    {
      "name": "ঢাকা-ফরিদপুর (সকাল: ৮:১৫)",
      "address": "সুন্দরবন এক্সপ্রেস\nসাপ্তাহিক বন্ধ বুধবার",
      "phone": []
    },
    {
      "name": "ঢাকা-ফরিদপুর (সকাল: ১১:৪০)",
      "address": "নক্সিকাথা কমিউটার",
      "phone": []
    },
    {
      "name": "ঢাকা-ফরিদপুর (বিকাল: ৩:০০)",
      "address": "মধুমতি",
      "phone": []
    },
    {
      "name": "ঢাকা-ফরিদপুর (রাত: ১১:৪৫)",
      "address": "বেনাপোল এক্সপ্রেস",
      "phone": []
    },
    {
      "name": "ঢাকা-ভাঙ্গা (সন্ধ্যা: ৬:00)",
      "address": "ভাঙ্গা কমিউটার",
      "phone": []
    }
  ]


















  ;

  // Adding each categories entry to Firestore under the "faridpur/categories" document
  for (var categories in categoriesData) {
    final categoriesName = categories['name'] as String;
    //change the categories name
    await firestore.collection('faridpur').doc('ট্রেন').set({
      categoriesName: {
        "name": categoriesName,
        "address": categories['address'] ?? "",
        "phone": categories['phone'] ?? [],
      }
    }, SetOptions(merge: true));
  }
}
