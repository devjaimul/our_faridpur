import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:our_faridpur/utlis/app_icons.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late Future<bool> _isConnected;

  // Check if the device is connected to the internet
  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Refresh data on pull-to-refresh
  Future<void> _refreshData() async {
    setState(() {
      _isConnected = _checkConnectivity(); // Recheck connectivity
    });
  }

  @override
  void initState() {
    super.initState();
    _isConnected = _checkConnectivity();  // Check connectivity when the slider is created
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final sizeW = MediaQuery.sizeOf(context).width;

    final String noInternet = AppIcons.internet;

    return FutureBuilder<bool>(
      future: _isConnected,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),  // Show while checking connectivity
          );
        }

        if (!snapshot.hasData || !snapshot.data!) {
          return Center(
            child: Lottie.asset(
              noInternet,  // Show Lottie animation if no internet
              width: sizeW * 0.5,
              height: sizeH * 0.3,
              fit: BoxFit.cover,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _refreshData,  // Attach pull-to-refresh functionality
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('images')
                .doc('slider images')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset(
                    noInternet, // Show Lottie animation while loading
                    width: sizeW * 0.5,
                    height: sizeH * 0.3,
                    fit: BoxFit.cover,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Lottie.asset(
                    noInternet, // Show Lottie animation in case of error
                    width: sizeW * 0.5,
                    height: sizeH * 0.3,
                    fit: BoxFit.cover,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data?.data() == null) {
                return Center(
                  child: Lottie.asset(
                    noInternet, // Show Lottie animation if no data is found
                    width: sizeW * 0.5,
                    height: sizeH * 0.3,
                    fit: BoxFit.cover,
                  ),
                );
              }

              var data = snapshot.data!.data() as Map<String, dynamic>?;

              List<String> imageUrls = data?.values.map((url) => url.toString()).toList() ?? [];

              if (imageUrls.isEmpty) {
                return Center(
                  child: Lottie.asset(
                    noInternet, // Show Lottie animation if image URLs are empty
                    width: sizeW * 0.5,
                    height: sizeH * 0.3,
                    fit: BoxFit.cover,
                  ),
                );
              }

              return CarouselSlider(
                options: CarouselOptions(
                  height: sizeH * 0.22,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                noInternet,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
