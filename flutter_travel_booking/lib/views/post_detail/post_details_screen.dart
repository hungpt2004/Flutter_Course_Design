import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/provider/post_provider.dart';
import 'package:flutter_travel_booking/theme/image/network_image.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import 'package:flutter_travel_booking/views/home/widget/hotel_list.dart';
import 'package:flutter_travel_booking/views/post_detail/widget/post_comment.dart';
import 'package:flutter_travel_booking/views/post_detail/widget/post_slide_image.dart';
import 'package:lottie/lottie.dart';
import '../../model/user.dart';
import '../../theme/color/color.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.user});

  final User? user;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final networkImage = NetworkImageWidget();

  @override
  Widget build(BuildContext context) {
    final readPost = ref.read(postProvider.notifier);
    final textStyle = TextStyleCustom();
    final boxSpace = BoxSpace();
    final networkImage = NetworkImageWidget();
    final currentUser = widget.user;

    return Scaffold(
      backgroundColor: white,

      // A P P B A R
      appBar: _customerAppBar(currentUser!, boxSpace, textStyle),

      // B O D Y
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imageField(),
            _titleField(readPost, textStyle),
            _contentField(readPost, textStyle),
            _translateField(boxSpace, textStyle),
            _postField(textStyle, readPost.currentPost!.createdAt),
            _featurePlaces(textStyle, boxSpace),
            boxSpace.spaceHeight(20, context),
            _discoverMore(textStyle, boxSpace),
            boxSpace.spaceHeight(20, context),
            boxSpace.spacer(context),
            boxSpace.spaceHeight(20, context,),
            PostCommentWidget(user: widget.user!,),
            boxSpace.spacer(context),
            boxSpace.spaceHeight(20, context,),
            _relatedTrip(textStyle,boxSpace),
            boxSpace.spaceHeight(10, context,),
            _discoverButton(textStyle)
          ],
        ),
      ),

      // C O M M E N T
      bottomNavigationBar: _commentField(textStyle,readPost),
    );
  }

  
  Widget _featurePlaces(TextStyleCustom textStyle, BoxSpace box) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Featured Places",
              style:
              textStyle.textStyleForm(16, FontWeight.w500, Colors.black)),
          box.spaceHeight(10, context),
          Container(
            width: StyleSize(context).screenWidth,
            height: StyleSize(context).heightPercent(150),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: white),
            child: Card(
              color: white,
              elevation: 10,
              child: Stack(
                children: [
                  Row(
                    children: [
                      // I M A G E
                      Stack(
                        children: [
                          SizedBox(
                            width: StyleSize(context).widthPercent(120),
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)
                              ),
                              child: networkImage.networkImage(
                                  'https://images.pexels.com/photos/10499275/pexels-photo-10499275.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: 20,
                              decoration: BoxDecoration(
                                color: deepGreen.withOpacity(0.6),
                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10))
                              ),
                              child: Center(
                                child: Text(
                                  "Attraction",
                                  style: textStyle.textStyleForm(
                                      12, FontWeight.w300, white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // I N F O R
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shumeikan",
                              style: textStyle.textStyleForm(
                                  16, FontWeight.w600, Colors.black),
                            ),
                            box.spaceHeight(5, context),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: lightBlue.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                child: Center(
                                  child: Text(
                                    'Hot Springs',
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle.textStyleForm(
                                        10, FontWeight.w400, Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            box.spaceHeight(5, context),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/vectors/address.svg',
                                  width: 15,
                                  height: 15,
                                ),
                                box.spaceWidth(5, context),
                                Text(
                                  "Hakone",
                                  style: textStyle.textStyleForm(
                                      10, FontWeight.w400, Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // V I E W BUTTON
                  Positioned(
                    bottom: 8, // Cách đáy Card 8px
                    right: 8, // Cách phải Card 8px
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: lightBlue,
                        ),
                        child: Center(
                          child: Text(
                            "View",
                            style: textStyle.textStyleForm(
                                12, FontWeight.w500, white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _relatedTrip(TextStyleCustom textStyle, BoxSpace box){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text("Related Trip Moments",
              style:
              textStyle.textStyleForm(16, FontWeight.w500, Colors.black)),
        ),
        box.spaceHeight(10, context),
        const HotelGridViewWidget()
      ],
    );
  }

  Widget _discoverButton(TextStyleCustom textStyle){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            width: 130,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: lightBlue,
                border: Border.all(color:  lightBlue,)
            ),
            child: Center(
              child: Text(
                "Discover More",
                style: textStyle.textStyleForm(
                    12, FontWeight.w400, white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _discoverMore(TextStyleCustom textStyle, BoxSpace box){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Discover More",
              style:
              textStyle.textStyleForm(16, FontWeight.w500, Colors.black)),
          box.spaceHeight(10, context),
          Container(
            width: StyleSize(context).screenWidth,
            decoration: BoxDecoration(
              color: lightBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: networkImage.networkImage('https://images.pexels.com/photos/13241304/pexels-photo-13241304.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                          ),
                        ),
                        box.spaceWidth(10, context),
                        Text("Matsumoto Travel Guide",
                            style:
                            textStyle.textStyleForm(14, FontWeight.w400, Colors.black))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset('assets/vectors/back.svg',width: 25,height: 25,),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _postField(TextStyleCustom textStyle, DateTime? createAt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Posted: ${textStyle.formatDateFromText(createAt!)}',
              style: textStyle.textStyleForm(12, FontWeight.w400, Colors.black))
        ],
      ),
    );
  }

  Widget _imageField() {
    return SizedBox(
        height: StyleSize(context).heightPercent(500),
        child: const PostSlideWidget());
  }

  Widget _translateField(BoxSpace box, TextStyleCustom textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: StyleSize(context).screenWidth,
        height: StyleSize(context).heightPercent(30),
        decoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: lightBlue.withOpacity(0.1))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/vectors/translate.svg',
                width: 25,
                height: 25,
              ),
              box.spaceWidth(10, context),
              Text("Translation provided by AI",
                  style: textStyle.textStyleForm(
                      12, FontWeight.w400, Colors.black)),
              box.spaceWidth(5, context),
              InkWell(
                onTap: () {},
                child: Text("Translate",
                    style: textStyle.textStyleForm(
                        12, FontWeight.w600, Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleField(PostProvider readPost, TextStyleCustom textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            readPost.currentPost!.title!,
            style: textStyle.textStyleForm(16, FontWeight.w500, Colors.black),
          )
        ],
      ),
    );
  }

  Widget _contentField(PostProvider readPost, TextStyleCustom textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
            readPost.currentPost!.content!,
            softWrap: true,
            style: textStyle.textStyleForm(12, FontWeight.w400, Colors.black),
          ))
        ],
      ),
    );
  }

  Widget _commentField(TextStyleCustom textStyle, PostProvider readPost) {
    return BottomAppBar(
      color: white,
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Leave a comment',
                hintStyle:
                    textStyle.textStyleForm(12, FontWeight.w400, Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buttonBottom('like.svg', () {},readPost.currentPost!.likes),
              _buttonBottom('heart.svg', () {},readPost.currentPost!.favoritesCount),
              _buttonBottom('comment.svg', () {},readPost.currentPost!.commentCount),
              _buttonBottom('share.svg', () {},readPost.currentPost!.shares),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buttonBottom(String url, VoidCallback function, int amount) {
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        width: 20,
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Text('$amount',style: TextStyle(fontSize: StyleSize(context).scale(11)),)
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset(
                'assets/vectors/$url',
                width: 25,
                height: 25,
              ),
            ),
          ],
        )
      ),
    );
  }

  PreferredSizeWidget _customerAppBar(User? currentUser, BoxSpace boxSpace, TextStyleCustom textStyle) {
    return AppBar(
      backgroundColor: white,
      title: Row(
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: networkImage.networkImage(currentUser!.avatar!),
            ),
          ),
          boxSpace.spaceWidth(8, context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // N A M E
                  Text(
                    currentUser.username,
                    maxLines: 2,
                    overflow: TextOverflow
                        .ellipsis, // Hiển thị dấu ba chấm nếu tiêu đề quá dài
                    style: textStyle.textStyleForm(
                        12, FontWeight.w500, Colors.black),
                  ),

                  boxSpace.spaceWidth(10, context),

                  // C O U N T R Y
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 3),
                      child: Center(
                        child: Text(
                          currentUser.country!,
                          overflow: TextOverflow
                              .ellipsis, // Hiển thị dấu ba chấm nếu tiêu đề quá dài
                          style: textStyle.textStyleForm(
                              10, FontWeight.w400, Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  boxSpace.spaceWidth(30, context),

                  //F O L L O W
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Follow',
                      overflow: TextOverflow
                          .ellipsis, // Hiển thị dấu ba chấm nếu tiêu đề quá dài
                      style: textStyle.textStyleForm(
                          12, FontWeight.w400, lightBlue),
                    ),
                  ),

                  boxSpace.spaceWidth(20, context),

                  // D R O P D O W N
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/vectors/choice.svg',
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),

              boxSpace.spaceHeight(2, context),

              //T Y P E - M E M B E R
              Container(
                height: 20,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFFDCA9)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Lottie.asset(
                            'assets/animations/member.json',
                            fit: BoxFit.contain,
                            height: 16, // Chiều cao cụ thể
                            width: 16, // Chiều rộng cụ thể),
                          )),
                      boxSpace.spaceWidth(2, context),
                      Text(
                        currentUser.memberType,
                        maxLines: 2,
                        overflow: TextOverflow
                            .ellipsis, // Hiển thị dấu ba chấm nếu tiêu đề quá dài
                        style: textStyle.textStyleForm(
                            10, FontWeight.w300, Colors.orange.shade900),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
