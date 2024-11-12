//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../utlis/app_colors.dart';
// import '../../utlis/app_icons.dart';
// import '../../utlis/app_images.dart';
// import '../../utlis/custom_text_style.dart';
//
//
// class CustomNavbar extends StatefulWidget {
//   const CustomNavbar({super.key});
//
//   @override
//   State<CustomNavbar> createState() => CustomNavbarState();
// }
//
// class CustomNavbarState extends State<CustomNavbar> {
//   List<Widget> screens = [
//     // const HomeScreen(),
//     // const WorkoutScreen(),
//     // const MealScreen(),
//     // const SportsScreen(),
//   ];
//
//   int currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // Register this state to be found by Get.find<CustomNavbarState>()
//     Get.put(this);
//   }
//
//   // Method to update the current index from external sources
//   void setCurrentIndex(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeH = MediaQuery.sizeOf(context).height;
//     final sizeW = MediaQuery.sizeOf(context).width;
//
//     // Initialize the ProfileController to access profile data
//     //final ProfileController profileController = Get.put(ProfileController());
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: currentIndex == 0
//             ?  Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const HeadingThree(data: 'Hello ✨'),
//             HeadingThree(data: profileController.profileData['name'] ?? ''),
//           ],
//         )
//             : null,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.to(const NotificationScreen());
//               },
//               icon: AppIcons.notification),
//           InkWell(
//             onTap: () {
//               Get.to(const ProfileScreen());
//             },
//             child: Obx(() {
//               // Use Obx to listen for changes in the profile data
//               return CircleAvatar(
//                 radius: sizeH * .02,
//                 backgroundImage: (profileController.profileData['image'] != null &&
//                     profileController.profileData['image'].isNotEmpty)
//                     ? NetworkImage('${Urls.imageBaseUrl}/${profileController.profileData['image']}')
//                     : const AssetImage(AppImages.profile) as ImageProvider,
//                 onBackgroundImageError: (_, __) {
//                   debugPrint('Failed to load network image.');
//                 },
//               );
//             }),
//           ),
//           SizedBox(
//             width: sizeW * .02,
//           )
//         ],
//       ),
//       body: screens[currentIndex],
//       bottomNavigationBar: Container(
//         height: sizeH * .06,
//         margin: EdgeInsets.all(sizeH * .014),
//         padding: EdgeInsets.all(sizeH * .01),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(sizeH * .05),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 10.r,
//               spreadRadius: 1.r,
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(Icons.home, "Home", 0),
//             _buildNavItem(Icons.fitness_center, "Workout", 1),
//             _buildNavItem(Icons.restaurant, "Meal plan", 2),
//             _buildNavItem(Icons.sports_soccer, "Sports", 3),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData iconData, String label, int index) {
//     final sizeH = MediaQuery.sizeOf(context).height;
//     final sizeW = MediaQuery.sizeOf(context).width;
//     bool isSelected = index == currentIndex;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           currentIndex = index;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: EdgeInsets.symmetric(horizontal: isSelected ? sizeW * .04 : sizeW * .0),
//         height: sizeH * .06,
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.primaryColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(sizeH * 0.5),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               iconData,
//               color: isSelected ? Colors.white : Colors.black,
//               size: sizeH * .03,
//             ),
//             if (isSelected)
//               Padding(
//                 padding: EdgeInsets.only(left: sizeW * .02),
//                 child: Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: sizeH * .02,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
