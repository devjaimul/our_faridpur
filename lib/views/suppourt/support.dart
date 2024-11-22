import 'package:flutter/material.dart';
import 'package:our_faridpur/utlis/custom_text_button.dart';
import 'package:our_faridpur/utlis/custom_text_style.dart';
import 'package:url_launcher/url_launcher.dart'; // To open URLs in the browser or other apps

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.sizeOf(context).height;
    final sizeW=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(title: const HeadingTwo(data: 'সাপোর্ট',color: Colors.white,),),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(sizeH*.016),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image: AssetImage('assets/images/appLogo2.png',),width: double.infinity,height: sizeH*.35,),
              SizedBox(height: sizeH*.05),
            const HeadingTwo(data: 'আমাদের ফরিদপুর'),
               SizedBox(height: sizeH*.016),
               Text(
                "আপনার কোনো তথ্যের প্রয়োজন অথবা কোনো পরামর্শ, অভিমত বা মন্তব্য জানাতে মেসেজ করুন।",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sizeH*.018,
                  color: Colors.black87,
                ),
              ),
               SizedBox(height: sizeH*.05),
             SizedBox(
                 width: sizeW*.5,
                 child: CustomTextButton(text: 'Send Message', onTap: (){_launchFacebookProfile(); }))
            ],
          ),
        ),
      ),
    );
  }

  void _launchFacebookProfile() async {
    final Uri facebookProfileUri = Uri.parse("https://www.facebook.com/akik404"); // Replace with your Facebook profile link

    if (await launchUrl(facebookProfileUri)) {
      await launchUrl(facebookProfileUri, mode: LaunchMode.externalApplication); // Ensures opening in browser or app
    } else {
      throw "Could not launch $facebookProfileUri";
    }
  }

}
