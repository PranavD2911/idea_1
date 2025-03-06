import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSliderForHomeScreen extends StatefulWidget {
  const ImageSliderForHomeScreen({super.key});

  @override
  State<ImageSliderForHomeScreen> createState() =>
      _ImageSliderForHomeScreenState();
}

class _ImageSliderForHomeScreenState extends State<ImageSliderForHomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/shop_items/item1.jpg",
      "assets/images/shop_items/item2.jpg",
      "assets/images/shop_items/item3.jpg",
      "assets/images/shop_items/item4.jpg",
      "assets/images/shop_items/item5.jpg"
    ];
    return Stack(alignment: Alignment.center, children: [
      CarouselSlider(
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
          onScrolled: (value) {},
          viewportFraction: 1,
          padEnds: false,
          disableCenter: true,
          // height: 150.0,
          enableInfiniteScroll: true,
          autoPlay: true,
          enlargeCenterPage: false,
        ),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(image))), //use 200x130 here
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              );
            },
          );
        }).toList(),
      ),
      Positioned(
        bottom: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((image) {
            int index = images.indexOf(image);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == currentIndex
                    ? Colors.purple
                    : Colors.grey.shade400,
              ),
            );
          }).toList(),
        ),
      )
    ]);
  }
}
