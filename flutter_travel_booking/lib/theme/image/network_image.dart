import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_booking/theme/color/color.dart';

class NetworkImageWidget {
  Widget networkImage(String url){
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CircularProgressIndicator(
              color: lightBlue,
              value: downloadProgress.progress),),
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(CupertinoIcons.info_circle),
        );
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeInOut,
    );
  }
}