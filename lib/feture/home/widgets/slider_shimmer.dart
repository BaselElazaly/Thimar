import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: 2,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: double.infinity,
                  color: Colors.white,
                );
              },
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.2,
                autoPlay: true,
                viewportFraction: 1,
              ),
            ),
          ],
        ));
  }
}
