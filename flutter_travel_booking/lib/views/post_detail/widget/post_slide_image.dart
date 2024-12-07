import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_travel_booking/provider/post_provider.dart';
import 'package:flutter_travel_booking/theme/color/color.dart';
import 'package:flutter_travel_booking/theme/image/network_image.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostSlideWidget extends ConsumerStatefulWidget {
  const PostSlideWidget({super.key});

  @override
  ConsumerState<PostSlideWidget> createState() => _PostSlideWidgetState();
}

class _PostSlideWidgetState extends ConsumerState<PostSlideWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final readPost = ref.read(postProvider.notifier).currentPost;
    final networkImage = NetworkImageWidget();
    final boxSpace = BoxSpace();
    return CarouselSlider.builder(
        itemCount: readPost!.images!.length,
        itemBuilder: (context, index, realIndex) {
          final imageIndex = readPost.images![index];
          return _showPostImage(imageIndex.url!, networkImage, readPost.images!.length, index, boxSpace);
        },
        options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          height: double.infinity,
          aspectRatio: 16/9,
          viewportFraction: 1,
          autoPlay: false,
          enlargeCenterPage: false
        ));
  }

  Widget _showPostImage(String url, NetworkImageWidget networkImage, int length, int index, BoxSpace boxSpace){
    return Container(
      width: StyleSize(context).screenWidth,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: StyleSize(context).screenWidth,
                height: 450,
                child: ClipRRect(
                  child: networkImage.networkImage(url),
                ),
              ),
              Positioned(
                right: 20,
                top: 20,
                child: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("${index+1}/$length"),
                  ),
                ),
              ),
            ],
          ),
          boxSpace.spaceHeight(15, context),
          dotSlide(currentIndex, length)
        ],
      ),
    );
  }

  Widget dotSlide(currentIndex, int length) {
    return AnimatedSmoothIndicator(
      duration: const Duration(milliseconds: 800),
      activeIndex: currentIndex,
      count: length,
      effect: const ExpandingDotsEffect(
        radius: 60,
        spacing: 7,
        activeDotColor: lightBlue,
        expansionFactor: 2,
        dotHeight: 6,
        dotWidth: 6,
      ),
    );
  }
}
