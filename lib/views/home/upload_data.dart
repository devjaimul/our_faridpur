import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadCategoriesData() async {
  final firestore = FirebaseFirestore.instance;

  // Define the data with the correct type Map<String, dynamic>
  final List<Map<String, dynamic>> categoriesData =[
    {
      "name": "হোটেল র‌্যাফেলস ইন্",
      "address": "ফরিদপুর সদর, ফরিদপুর",
      "phone": ["01712700050", "01711034727"],

    },
    {
      "name": "হোটেল রাজস্থান",
      "address": "ফরিদপুর সদর, ফরিদপুর",
      "phone": ["01949581582", "01778572221","0631-67224"]
    },
    {
      "name": "হোটেল লাক্সারী",
      "address": "ফরিদপুর সদর, ফরিদপুর",
      "phone": ["0631-62623"]
    },
    {
      "name": "জে.কে ইন্টারন্যাশনাল",
      "address": "ফরিদপুর সদর, ফরিদপুর",
      "phone": ["0631-61869","017088872266", "01756900409 (অফিস)"]
    },
    {
      "name": "হোটেল পদ্মা",
      "address": "ফরিদপুর সদর, ফরিদপুর",
      "phone": ["0631-62685"]
    },
    {
      "name": "ধান গবেষণা কেন্দ্র গেস্ট হাউস",
      "address": "ফরিদপুর সদর, ফরিদপুর",
      "phone": ["06323-56329"]
    },
    {
      "name": "সার্কিট হাউজ ফরিদপুর (শাহাদাত)",
      "address": "জেলা প্রশাসকের কার্যালয়, ফরিদপুর",
      "phone": ["01778905054"]
    },
    {
      "name": "সার্কিট হাউজ ফরিদপুর (মুন্সী)",
      "address": "জেলা প্রশাসকের কার্যালয়, ফরিদপুর",
      "phone": ["01933-151923","02478802719"]
    },
    {
      "name": "সার্কিট হাউজ ফরিদপুর (তুহিন)",
      "address": "জেলা প্রশাসকের কার্যালয়, ফরিদপুর",
      "phone": ["01795109488","0631-63120"]
    },

  ]
  ;

  // Adding each categories entry to Firestore under the "faridpur/categories" document
  for (var categories in categoriesData) {
    final categoriesName = categories['name'] as String;
    //change the categories name
    await firestore.collection('faridpur').doc('hotel').set({
      categoriesName: {
        "name": categoriesName,
        "address": categories['address'] ?? "",
        "phone": categories['phone'] ?? [],
      }
    }, SetOptions(merge: true));
  }
}
