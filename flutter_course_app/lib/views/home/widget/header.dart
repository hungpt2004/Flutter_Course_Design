import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/data/space_style.dart';
import '../../../theme/data/style_image.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    debugPrint(authProvider.user?.userId);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 40,height: 40,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,),),),
        Row(
          children: [
            SizedBox(width: 40,height: 40,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/noti.png"),),),
            SpaceStyle.boxSpaceWidth(10),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
                  // imageUrl: authProvider.user!.url, => real avatar from avatar
                 child: ImageNetworkStyle.networkImage("https://www.pngitem.com/pimgs/m/130-1300253_female-user-icon-png-download-user-image-color.png")
              ),
            )
          ],
        )
      ],
    );
  }
}
