import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:our_faridpur/utlis/app_colors.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';


class CustomDialog extends StatelessWidget {
  final String title;
  final String? cancelButtonText;
  final String? confirmButtonText;
  final Color? confirmButtonColor;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    this.cancelButtonText = "Cancel",
    this.confirmButtonText = "Log Out",
    required this.onCancel,
    required this.onConfirm, this.confirmButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close, size: 24.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 8.h),
            // Title Text
            Center(
              child: Text(title,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)
            ),
            SizedBox(height: 24.h),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: HeadingThree(data: cancelButtonText.toString(),color: Colors.white)
                  ),
                ),
                SizedBox(width: 10.w),
                // Confirm Button
                Expanded(
                  child: TextButton(
                    onPressed: onConfirm,
                    style: TextButton.styleFrom(
                      backgroundColor:confirmButtonColor?? Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: HeadingThree(data: confirmButtonText.toString(),color: Colors.white,)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}