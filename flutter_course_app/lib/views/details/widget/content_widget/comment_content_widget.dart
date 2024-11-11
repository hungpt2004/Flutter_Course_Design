import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_button.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constant/color.dart';
import '../../../../theme/data/style_text.dart';

class CommentContentWidget extends StatefulWidget {
  const CommentContentWidget({super.key});

  @override
  State<CommentContentWidget> createState() => _CommentContentWidgetState();
}

class _CommentContentWidgetState extends State<CommentContentWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider =
        AuthenticationProvider.stateAuthenticationProvider(context);
    final loadProvider = LoadingProvider.stateLoadingProvider(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 2, // Số lượng bình luận
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10), // Khoảng cách giữa các bình luận
                  child: Container(
                    decoration: BoxDecoration(
                      color: kDefaultColor, // Màu nền cho container
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow phía dưới
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: StyleSize(context).widthPercent(50),
                            height: StyleSize(context).heightPercent(50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ImageNetworkStyle.networkImage(
                                  authProvider.user!.url),
                            ),
                          ),
                          SpaceStyle.boxSpaceWidth(
                              15, context), // Khoảng cách giữa ảnh và nội dung
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text của bình luận
                                index == 1
                                    ? Text(
                                        'Help to me so much!',
                                        style: TextStyleApp.textStyleForm(
                                          16,
                                          FontWeight.w500,
                                          kCardTitleColor,
                                        ),
                                      )
                                    : Text(
                                        'Nice course!',
                                        style: TextStyleApp.textStyleForm(
                                          16,
                                          FontWeight.w500,
                                          kCardTitleColor,
                                        ),
                                      ),
                                // Text đánh giá sao
                                Text("⭐⭐⭐⭐⭐",
                                    style: TextStyleApp.textStyleForm(
                                        14, FontWeight.w400, kDefaultColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: TextFormField(
                style: TextStyleApp.textStyleForm(16, FontWeight.w500, kDefaultColor),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  hintText: 'Enter your comment ...',
                  hintStyle: TextStyleApp.textStyleForm(16, FontWeight.w500, kDefaultColor),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ButtonStyleApp.normalButton((){}, "Send", kPrimaryColor, kDefaultColor, kDefaultColor, 20, 10, 20),
                  )
                ),
                maxLines: 3,

              ))
        ],
      ),
    );
  }
}
