import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_faridpur/routes/routes_name.dart';
import 'package:our_faridpur/utlis/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteNames.customNavBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.2), // Dark grayish-black background
      body: Center(
        child: Image(image: AssetImage('assets/images/appLogo2.png',),width: sizeW*.8,),
      ),
    );
  }
}
