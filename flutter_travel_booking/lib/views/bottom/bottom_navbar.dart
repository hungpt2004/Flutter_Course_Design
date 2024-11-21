import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/provider/page_provider.dart';
import 'package:flutter_travel_booking/theme/color/color.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import 'package:flutter_travel_booking/views/home/home_screen.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(pageProvider);
    final readPageProvider = ref.read(pageProvider.notifier);
    final textStyle = TextStyleCustom();

    List<Widget> pages = [
      const HomeScreen(),
      const Scaffold(
        body: Center(
          child: Text("Second Page"),
        ),
      ),
      const Scaffold(
        body: Center(
          child: Text("Third Page"),
        ),
      ),
      const Scaffold(
        body: Center(
          child: Text("Fourth Page"),
        ),
      )
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        height: StyleSize(context).heightPercent(90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            button((){readPageProvider.toggleChangePage(0);}, currentIndex == 0 ? 'home_click.svg' : 'home.svg', "Home",textStyle,currentIndex == 0 ? lightBlue : Colors.grey),
            button((){readPageProvider.toggleChangePage(1);}, currentIndex == 1 ? 'msg_click.svg' : 'msg.svg', "Message",textStyle,currentIndex == 1 ? lightBlue : Colors.grey),
            button((){readPageProvider.toggleChangePage(2);}, currentIndex == 2 ? 'bag_click.svg' : 'bag.svg', "My Trips",textStyle,currentIndex == 2 ? lightBlue : Colors.grey),
            button((){readPageProvider.toggleChangePage(3);}, currentIndex == 3 ? 'account_click.svg' : 'account.svg', "Account",textStyle,currentIndex == 3 ? lightBlue : Colors.grey)
          ],
        ),
      ),
    );
  }
  Widget button(VoidCallback function, String endpointSvg, String text, TextStyleCustom textStyle, Color color){
    return TextButton(
        onPressed: function,
        child: Column(
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: ClipRRect(
                child: SvgPicture.asset('assets/vectors/$endpointSvg',fit: BoxFit.cover,),
              ),
            ),
            Text(text,style: textStyle.textStyleForm(12, FontWeight.w300, color),)
          ],
        ));
  }
}

