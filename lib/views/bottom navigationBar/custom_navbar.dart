
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:our_faridpur/views/blood/blood_screen.dart';
import 'package:our_faridpur/views/home/home_screen.dart';
import 'package:our_faridpur/views/suppourt/support.dart';
import '../../../utlis/app_colors.dart';


class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => CustomNavbarState();
}

class CustomNavbarState extends State<CustomNavbar> {
  List<Widget> screens = [
    const HomeScreen(),
   const BloodScreen(),
  const SupportScreen()
  ];

  int currentIndex = 0;


  // Method to update the current index from external sources
  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;



    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: sizeH * .06,
        margin: EdgeInsets.all(sizeH * .014),
        padding: EdgeInsets.all(sizeH * .01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(sizeH * .05),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "হোম", 0),
            _buildNavItem(Icons.water_drop, "রক্ত", 1),
           // _buildNavItem(Icons.event, "ইভেন্ট", 2),
            _buildNavItem(Icons.support_agent, "সাপোর্ট", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData iconData, String label, int index) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;
    bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isSelected ? sizeW * .05 : sizeW * .0),
        height: sizeH * .06,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(sizeH * 0.5),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: isSelected ? Colors.white : Colors.black,
              size: sizeH * .03,
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: sizeW * .02),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sizeH * .02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
