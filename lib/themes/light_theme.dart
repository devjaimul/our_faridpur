import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utlis/app_colors.dart';



ThemeData lightTheme(context) {
  final sizeH = MediaQuery.sizeOf(context).height;
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),

      useMaterial3: true,
      appBarTheme:  const AppBarTheme(
        centerTitle: true,
        backgroundColor:  AppColors.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: AppColors.iconColor,
          suffixIconColor: AppColors.iconColor,
          fillColor: Colors.white,
          filled: true,
         helperStyle: TextStyle(color: Colors.white,fontSize: sizeH*.014),
         hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(50.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(50.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(50.r),
          )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.primaryColor,foregroundColor: Colors.white)



  );
}
