import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:our_faridpur/utlis/app_icons.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:our_faridpur/views/home/list_screen.dart';
import 'package:our_faridpur/widgets/slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Hospital', 'icon': Icons.local_hospital, 'lottie': AppIcons.hospital},
    {'name': 'Hotel', 'icon': Icons.hotel, 'lottie': null},
    {'name': 'Ambulance', 'icon': Icons.local_shipping, 'lottie': null},
    {'name': 'Police', 'icon': Icons.local_police, 'lottie': null},
  ];

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.sizeOf(context).height;
    final sizeW=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: HeadingTwo(data: "আমাদের ফরিদপুর",color: Colors.white,),

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeH*.015),
          child: Column(
            children: [
              const ImageSlider(),
              SizedBox(height: sizeH*0.025,),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final String name = category['name'] as String;
                  final IconData icon = category['icon'] as IconData;
                  final String? lottiePath = category['lottie'] as String?;

                  return GestureDetector(
                    onTap: () {
                     Get.to(ListScreen(category: name));
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(sizeH*.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Display Lottie animation if available, otherwise show the default icon
                            if (lottiePath != null)
                              SizedBox(
                                height: sizeH*.1,
                                child: Lottie.asset(
                                  lottiePath,


                                ),
                              )
                            else
                              Icon(
                                icon,
                                size: sizeH*.1,
                                color: Colors.blue,
                              ),
                             SizedBox(height: sizeH*.008),
                            HeadingTwo(data: name,fontSize: sizeH*.02,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
