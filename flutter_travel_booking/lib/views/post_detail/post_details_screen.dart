import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/provider/post_provider.dart';
import 'package:flutter_travel_booking/theme/image/network_image.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
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
    final currentUser = widget.user;

    return Scaffold(
      backgroundColor: white,

      // A P P B A R
      appBar: _customerAppBar(currentUser!, boxSpace, textStyle),

      // B O D Y
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: StyleSize(context).heightPercent(500),child: const PostSlideWidget()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text(readPost.currentPost!.title!,style: textStyle.textStyleForm(16, FontWeight.w500, Colors.black),)],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(
                children: [
                  Expanded(child: Text(readPost.currentPost!.content!,softWrap: true,overflow: TextOverflow.clip, style: textStyle.textStyleForm(12, FontWeight.w400, Colors.black),))
                ],
              ),
            )
          ],
        ),
      ),

      // C O M M E N T
      bottomNavigationBar: _commentField(),
    );
  }

  Widget _commentField(){
    return BottomAppBar(

    );
  }

  PreferredSizeWidget _customerAppBar(User? currentUser, BoxSpace boxSpace, TextStyleCustom textStyle){
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
                    child: SvgPicture.asset('assets/vectors/choice.svg',width: 20,height: 20,),
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
