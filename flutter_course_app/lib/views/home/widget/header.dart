import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/theme/style/space_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 40,height: 40,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/logo2.png"),),),
        Row(
          children: [
            SizedBox(width: 30,height: 30,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/noti.png"),),),
            SpaceStyle.boxSpaceWidth(10),
            Container(
              width: 30,
              height: 30,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Photos.png",
                  // imageUrl: authProvider.user!.url,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress),),
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(CupertinoIcons.info_circle),
                    );
                  },
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeInCurve: Curves.easeInOut,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
