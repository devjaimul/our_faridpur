import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_faridpur/views/home/list_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final categories = ['Hospital', 'Hotel', 'Ambulance', 'Police']; // You can fetch this dynamically if needed

    return Scaffold(
      appBar: AppBar(
        title: Text('Our Faridpur City'),
        backgroundColor: Colors.blue, // Replace with your color
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the ListScreen when a category is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListScreen(category: category),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


// [
// {
// "name": "ইসলামী ব্যাংক কমিউনিটি হাসপাতাল",
// "address": "",
// "phone": ["01731848464", "01923416383", "0631-66603"]
// },
// {
// "name": "ডায়বেটিক এসোসিয়েসন মেডিকেল কলেজ ও হাসপাতাল",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["01711703913", "0631-61488", "0631-63496"]
// },
// {
// "name": "হার্ট ফাউন্ডেশন হাসপাতাল",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["01708531770", "0631-64798"]
// },
// {
// "name": "ফরিদপুর সমরিতা জেনারেল হাসপাতাল লিঃ",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["0631-65813", "01712-122910"],
// "note": "সিরিয়ালের জন্য 01712-122910,01719-285913, অভিযোগ নম্বর 01755-578642"
// },
// {
// "name": "পরিচর্যা হাসপাতাল",
// "address": "গোয়ালচামট, ফরিদপুর সদর উপজেলা",
// "phone": ["0631-63100", "0631-64200", "01711468681"]
// },
// {
// "name": "আহমাদ আই হসপিটাল এন্ড ফেকো সেন্টার",
// "address": "১১/১৬, লিলিয়ারা টাওয়ার, (৩য়-৫ম তলা), মুজিব সড়ক (প্রেস ক্লাব সংলগ্ন) নিলটুলী, ফরিদপুর",
// "phone": ["01334717111"]
// },
// {
// "name": "মালেকা চক্ষু হাসপাতাল",
// "address": "মধুখালী, ফরিদপুর",
// "phone": ["01720083551"]
// },
// {
// "name": "সেবা ডেন্টাল কেয়ার",
// "address": "",
// "phone": ["01716335452"]
// },
// {
// "name": "জনতা হসপিটাল এন্ড ডায়াগনস্টিক সেন্টার",
// "address": "পশিম খাবাসপুর, মেডিকেল কলেজ হাসপাতাল",
// "phone": ["01753527373", "01777151692"]
// },
// {
// "name": "ফরিদপুর পিয়ারলেস প্রাইভেট হাসপাতাল এন্ড ডিজিটাল ডায়াগনস্টিক সেন্টার",
// "address": "গোয়ালচামট, পুরাতন বাসস্ট্যান্ড, ফরিদপুর",
// "phone": ["01774737888", "01711518569"]
// },
// {
// "name": "সৌদি বাংলা (প্রাঃ) হাসপাতাল",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["01998019008", "01788994993"],
// "note": "সিরিয়ালের জন্য 01717209823"
// },
// {
// "name": "ফরিদপুর সেন্ট্রাল হসপিটাল",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["01790008900"]
// },
// {
// "name": "জেনারেল হাসপাতাল",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["01711282727"]
// },
// {
// "name": "নুর স্পেশালাইজড হসপিটাল",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["01781968067", "01976299474"]
// },
// {
// "name": "দেশ ক্লিনিক",
// "address": "ফরিদপুর সদর উপজেলা",
// "phone": ["0631-64160"]
// },
// {
// "name": "দি নিরাময় ক্লিনিক",
// "address": "",
// "phone": ["0631-62588"]
// },
// {
// "name": "আনোয়ারা হামিদা চক্ষু হাসপাতাল",
// "address": "",
// "phone": ["0631-66050"]
// },
// {
// "name": "পরিবার পরিকল্পনা অফিস",
// "address": "ফরিদপুর সদর, ফরিদপুর",
// "phone": ["01712700066"]
// },
// {
// "name": "হ্যাপি হসপিটাল এন্ড ডায়াগনস্টিক সেন্টার (প্রা:) লি: ফরিদপুর",
// "address": "",
// "phone": ["01719583975", "07123692028", "01717173311"]
// },
// {
// "name": "এ্যারাবিয়ান হাসপাতাল",
// "address": "",
// "phone": []
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, নগরকান্দা উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["01711908727"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, আলফাডাঙ্গা উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["01712285410"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, চরভদ্রাসন উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["01711260040"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, সদরপুর উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["01715124420"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, সালথা উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["01711-908727"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, মধুখালী উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["0626-71291"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, বোয়ালমারী উপজেলা, ফরিদপুর",
// "address": "",
// "phone": ["01712-509001"]
// },
// {
// "name": "উপজেলা স্বাস্থ্য কমপ্লেক্স, ভাঙ্গা, ফরিদপুর",
// "address": "",
// "phone": ["01717-249177"]
// },
// {
// "name": "প্রভাতী হাসপাতাল",
// "address": "",
// "phone": ["01749-062939"]
// },
// {
// "name": "রাবেয়া ক্লিনিক",
// "address": "",
// "phone": []
// },
// {
// "name": "জাহেদ মেমোরিয়াল শিশু হাসপাতাল",
// "address": "ফরিদপুর সদর",
// "phone": ["01711-006786"]
// },
// {
// "name": "ফরিদপুর মা ও শিশু জেনারেল হাসপাতাল",
// "address": "",
// "phone": ["01703343534"]
// },
// {
// "name": "মা ও শিশু কল্যাণ কেন্দ্র",
// "address": "",
// "phone": []
// }
// ]

