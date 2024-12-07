import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/theme/color/color.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import 'package:flutter_travel_booking/views/home/widget/category_button.dart';
import 'package:flutter_travel_booking/views/home/widget/discount.dart';
import 'package:flutter_travel_booking/views/home/widget/hotel_list.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  BoxSpace boxSpace = BoxSpace();
  TextStyleCustom textStyleCustom = TextStyleCustom();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightBlue,
              white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1,0.4]
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 20,
              backgroundColor: white,
              expandedHeight: 70,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                //hieu ung khi bi thu gon
                collapseMode: CollapseMode.parallax,
                //hieu ung khi keo xuong qua gioi han
                stretchModes: const [
                  StretchMode.zoomBackground,
                ],
                background: Container(
                  color: lightBlue.withOpacity(0.85),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // Thay đổi chiều rộng dựa vào trạng thái AppBar
                      width:
                          StyleSize(context).widthPercent(220), // Bình thường
                      height: StyleSize(context).heightPercent(30),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/vectors/search.svg',
                              width: 15,
                              height: 15,
                            ),
                            boxSpace.spaceWidth(10, context),
                            Expanded(
                              child: Text(
                                "Awaken Da Nang Hotel",
                                style: textStyleCustom.textStyleForm(
                                  8,
                                  FontWeight.w300,
                                  Colors.black,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/vectors/bot.svg',
                              width: 15,
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    boxSpace.spaceWidth(10, context),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/vectors/gold.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    boxSpace.spaceHeight(10, context),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 15,
                        child: Container(
                            width: StyleSize(context).screenWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buttonBanner(() {}, "Hotels", 'hotel.svg',
                                          textStyleCustom, context),
                                      _buttonBanner(
                                          () {},
                                          "Flights",
                                          'plane.svg',
                                          textStyleCustom,
                                          context),
                                      _buttonBanner(
                                          () {},
                                          "Restaurant",
                                          'restaurant.svg',
                                          textStyleCustom,
                                          context),
                                      _buttonBanner(() {}, "Trains", 'train.svg',
                                          textStyleCustom, context),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buttonBanner(() {}, "Attractions & Tours",
                                          'tour.svg', textStyleCustom, context),
                                      _buttonBanner(
                                          () {},
                                          "Airport Transfers",
                                          'airport.svg',
                                          textStyleCustom,
                                          context),
                                      _buttonBanner(() {}, "Car Rentals",
                                          'car.svg', textStyleCustom, context),
                                      _buttonBanner(() {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                          isExpanded ? "Hide" : "+2 more",
                                          isExpanded ? 'up.svg' : 'drop.svg',
                                          textStyleCustom,
                                          context),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    boxSpace.spaceHeight(5, context),
                    if (isExpanded) _expandBanner(textStyleCustom, context),
                    boxSpace.spaceHeight(10, context),
                    //Discover
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: _location(() {}, "Discover", textStyleCustom,
                          boxSpace, context),
                    ),

                    boxSpace.spaceHeight(20, context),
                    _category(context),
                    _discount(context, textStyleCustom),
                    _post(context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buttonBanner(VoidCallback function, String text, String url,
    TextStyleCustom textStyle, BuildContext context) {
  return SizedBox(
    width: StyleSize(context).widthPercent(70),
    height: StyleSize(context).heightPercent(70),
    child: Column(
      children: [
        InkWell(
          onTap: function,
          child: SvgPicture.asset(
            'assets/vectors/$url',
            width: StyleSize(context).widthPercent(25),
            height: StyleSize(context).heightPercent(25),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle.textStyleForm(10, FontWeight.w500, Colors.black),
        )
      ],
    ),
  );
}

Widget _expandBanner(TextStyleCustom textStyleCustom, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 15,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: white),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  _buttonBanner(() {}, "Partnership", 'hand.svg',
                      textStyleCustom, context),
                  _buttonBanner(() {}, "About Trip.com", 'infor.svg',
                      textStyleCustom, context),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _category(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ButtonEventWidget(url: 'deals.svg', text: "Deals", function: () {}),
          ButtonEventWidget(url: 'event.svg', text: "Events", function: () {}),
          ButtonEventWidget(url: 'trend.svg', text: "Trends", function: () {}),
          ButtonEventWidget(url: 'trip_best.svg', text: "Trip.Best", function: () {}),
          ButtonEventWidget(url: 'location.svg', text: "Itinerary", function: () {}),
          ButtonEventWidget(url: 'guides.svg', text: "Travel Guides", function: () {}),
          ButtonEventWidget(url: 'moment.svg', text: "Moments", function: () {}),
        ],
      ),
    ),
  );
}

Widget _discount(BuildContext context, TextStyleCustom textStyle) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 15,
      child: Container(
          width: StyleSize(context).screenWidth,
          height: StyleSize(context).heightPercent(130),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [lightBlue.withOpacity(0.1), white],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                stops: const [0.005, 0.5],
              )),
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.all(StyleSize(context).moderateScale(8)),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Lottie.asset('assets/animations/discount_main.json',
                                width: 30, height: 30),
                            Text(
                              "New User Discounts Available",
                              style: textStyle.textStyleForm(
                                  12, FontWeight.w600, Colors.black),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                width: 60,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: lightBlue,
                                ),
                                child: Center(
                                  child: Text(
                                    "Claim All",
                                    style: textStyle.textStyleForm(
                                        10, FontWeight.w500, white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const Expanded(
                    flex: 2,
                    child: DiscountWidget(),
                  ),
                ],
              ),
            ),
          )),
    ),
  );
}

Widget _location(VoidCallback function, String text, TextStyleCustom textStyle,
    BoxSpace boxSpace, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle.textStyleForm(14, FontWeight.w700, Colors.black),
          ),
          boxSpace.spaceWidth(10, context),
          Chip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.white),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            elevation: 10,
            deleteIcon: const Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.black,
            ),
            label: Text(
              "World",
              style:
                  textStyle.textStyleForm(12, FontWeight.w500, Colors.black),
            ),
            onDeleted: () {},
          ),
        ],
      ),
      Row(
        children: [
          SvgPicture.asset(
            'assets/vectors/map.svg',
            width: 20,
            height: 20,
          ),
          Text("Map",
              style: textStyle.textStyleForm(14, FontWeight.w500, lightBlue))
        ],
      )
    ],
  );
}

Widget _post(BuildContext context) {
  return const HotelGridViewWidget();
}
