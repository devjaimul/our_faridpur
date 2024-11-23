import 'package:flutter/material.dart';
import 'package:our_faridpur/utlis/app_colors.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:our_faridpur/views/blood/donar/donar_list_screen.dart';

import 'post/blood_post_screen.dart';


class BloodScreen extends StatelessWidget {
  const BloodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2, // Two tabs: Requested and Confirmed
      child: Scaffold(
        appBar: AppBar(
          title:const HeadingTwo(data: 'রক্ত',color: Colors.white,),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.4),
            dividerColor: AppColors.primaryColor.withOpacity(0.5),

            labelStyle: TextStyle(
              fontSize: sizeHeight*.02,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(
                  child:Text('পোস্ট',)
              ),
              Tab(
                  child:Text('ডোনার')
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
        BloodPostScreen(),
            DonorListScreen(),


          ],
        ),
      ),
    );
  }


}
