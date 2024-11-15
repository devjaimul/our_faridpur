import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.sizeOf(context).height;
    final sizeW=MediaQuery.sizeOf(context).width;
    final String errorImage = 'https://imgs.search.brave.com/KnqrQBllEEiETdBaqaCXT3Rx0MDEgoIptjSGT9vGDW4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvODYw/NDYzNTIyL3ZlY3Rv/ci80MDQtZXJyb3It/cGFnZS10ZW1wbGF0/ZS1mb3Itd2Vic2l0/ZS00MDQtYWxlcnQt/ZmxhdC1kZXNpZ24u/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PWFkMEQ1Y1FxblJN/UmN5UXRhRmRyazRH/Z085TFlSWWwwNlY0/TVJlWktzT0U9';
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('images')
          .doc('slider images')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Image.network(
              errorImage,
              fit: BoxFit.cover,
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return Center(
            child: Image.network(
              errorImage,
              fit: BoxFit.cover,
            ),
          );
        }

        var data = snapshot.data!.data() as Map<String, dynamic>?;

        List<String> imageUrls = data?.values.map((url) => url.toString()).toList() ?? [];

        if (imageUrls.isEmpty) {
          return Center(
            child: Image.network(
              errorImage,
              fit: BoxFit.cover,
            ),
          );
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: sizeH*.22,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: imageUrls.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.symmetric(horizontal: sizeW*.005),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Clip the image with the border radius
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
                          errorImage,
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
    );
  }
}
