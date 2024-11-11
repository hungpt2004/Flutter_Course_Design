import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/routes/animation_routes.dart';
import 'package:course_app_flutter/theme/data/style_toast.dart';
import 'package:course_app_flutter/views/form/auth_screen.dart';
import 'package:flutter/material.dart';

import '../../theme/data/space_style.dart';
import '../../theme/data/style_text.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final loadProvider = LoadingProvider.stateLoadingProvider(context);
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/banner.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4), // Adjust opacity as needed
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _containerText(
                        TextStyleApp.normalText('Meet Our Expert Instructors', 24,
                            FontWeight.w700, kDefaultColor),
                        200,
                        64),
                    SpaceStyle.boxSpaceHeight(16,context),
                    _containerText(
                        TextStyleApp.normalText(
                            'Learn with 100% coding lesson, at your own pace, and 100% updated content',
                            16,
                            FontWeight.w500,
                            kDefaultColor),
                        250,
                        70),
                    SpaceStyle.boxSpaceHeight(16,context),
                    _buttonGetStarted(loadProvider,context),
                    SpaceStyle.boxSpaceHeight(24,context),
                    _containerText(
                        Row(
                          children: [
                            TextStyleApp.normalText(
                                'Already have account?',
                                16,
                                FontWeight.w500,
                                kDefaultColor
                            ),
                            TextButton(onPressed: (){
                              _goToAuthPage(context);
                            }, child: TextStyleApp.normalText("Log in", 16, FontWeight.w500, kPrimaryColor))
                          ],
                        ),
                        250,
                        70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _containerText(Widget widget, double w, double h) {
  return SizedBox(
    width: w,
    height: h,
    child: widget,
  );
}

Widget _buttonGetStarted(LoadingProvider loadProvider, BuildContext context){
  return ElevatedButton(
      style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(4),
          backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
          shape: WidgetStatePropertyAll( loadProvider.isLoading ?  const CircleBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          fixedSize: const WidgetStatePropertyAll(Size(234,46)),
          animationDuration: const Duration(milliseconds: 800)
      ),
      onPressed: () async {
        await loadProvider.loading();
      },
      child: loadProvider.isLoading ? const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: kDefaultColor,),) : TextStyleApp.normalText(
          'Get started', 16, FontWeight.w700, kDefaultColor)
  );
}

// _goToAuthPage(BuildContext context){
//   return Navigator.pushNamed(context, "/auth");
// }

_goToAuthPage(BuildContext context){
  Navigator.of(context).push(Transitions.scaleTransition(const AuthenticationScreen()));
}