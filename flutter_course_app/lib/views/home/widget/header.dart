import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/theme/style/space_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    return Row(
      children: [
        Expanded(child: SizedBox(width: 20,height: 20,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/logo2.png"),),)),
        Expanded(child: Row(
          children: [
            SizedBox(width: 20,height: 20,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/noti.png"),),),
            SpaceStyle.boxSpaceWidth(10),
            CircleAvatar(
              child: CachedNetworkImage(
                imageUrl: authProvider.user!.url,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Icon(CupertinoIcons.info_circle),
                  );
                },
                fadeInDuration: Duration(milliseconds: 800),
                fadeInCurve: Curves.easeInOut,
              ),
            )
          ],
        ))
      ],
    );
  }
}
