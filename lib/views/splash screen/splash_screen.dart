import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/routes/routes_name.dart';
import 'package:our_faridpur/utlis/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteNames.onboardingScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC0CCFF), // Top color (light)
              Color(0xFF5271FF), // Bottom color (dark)
            ],
          ),
        ),
        child: Center(
          child: Image(
            image: const AssetImage(AppImages.logoBlack),
            width: double.infinity, // Adjust as needed
            height: sizeH*.32, // Adjust as needed
          ),
        ),
      ),
    );
  }
}
