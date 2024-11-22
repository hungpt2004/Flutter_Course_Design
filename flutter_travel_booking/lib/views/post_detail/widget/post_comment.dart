import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/model/quickly_reply.dart';
import 'package:flutter_travel_booking/provider/post_provider.dart';
import 'package:flutter_travel_booking/provider/user_provider.dart';
import 'package:flutter_travel_booking/repository/user_repository.dart';
import 'package:flutter_travel_booking/theme/color/color.dart';
import 'package:flutter_travel_booking/theme/image/network_image.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import '../../../model/comment.dart';
import '../../../model/post.dart';
import '../../../model/user.dart';

class PostCommentWidget extends ConsumerStatefulWidget {
  const PostCommentWidget({super.key, required this.user});

  final User user;

  @override
  ConsumerState<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends ConsumerState<PostCommentWidget> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readPost = ref.read(postProvider.notifier);
    //When have login
    final readUser = ref.read(userProvider.notifier);
    final textStyle = TextStyleCustom();
    final boxSpace = BoxSpace();
    final networkImage = NetworkImageWidget();
    final userRepository = UserRepository();

    debugPrint(
        "Current post id from provider ${readPost.currentPost!.id.toString()}");

    return SizedBox(
      width: StyleSize(context).screenWidth,
      height: StyleSize(context).heightPercent(280),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _quantityComment(readPost, textStyle),
            boxSpace.spaceHeight(10, context),
            _quicklyReply(textStyle, boxSpace),
            boxSpace.spaceHeight(10, context),
            _inputComment(_commentController, networkImage, widget.user, boxSpace, textStyle),
            _renderComment(networkImage, readPost, widget.user, textStyle, boxSpace, userRepository),
            Divider(
              height: 1,
               color: Colors.grey.withOpacity(0.3),
               thickness: 0.5,
            ),
            boxSpace.spaceHeight(10, context),
            _showMoreButton(textStyle)
          ],
        ),
      ),
    );
  }

  // Q U A N T I T Y -- C O M M E N T
  Widget _quantityComment(PostProvider readPost, TextStyleCustom textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('${readPost.currentPost!.comments!.length} comments',
            style: textStyle.textStyleForm(12, FontWeight.w400, Colors.black))
      ],
    );
  }

  // Q U I C K -- R E P L Y
  Widget _quicklyReply(TextStyleCustom textStyle, BoxSpace boxSpace) {
    return Row(
      children: [
        Text('Quickly Reply',
            style:
                textStyle.textStyleForm(12, FontWeight.w400, Colors.black54)),
        boxSpace.spaceWidth(10, context),
        Expanded(
          child: SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: replies.length,
              itemBuilder: (context, index) {
                final replyIndex = replies[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(replyIndex.trim(),
                        style: textStyle.textStyleForm(
                            10, FontWeight.w400, Colors.black)),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  // R E N D E R -- C O M M E N T
  Widget _renderComment(NetworkImageWidget networkImage, PostProvider readPost, User user, TextStyleCustom textStyle, BoxSpace boxSpace, UserRepository repository) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          final commentFirst = readPost.currentPost!.comments![0];
          final commentUser =  repository.getUserByUserID(commentFirst.userID!);
          return _cardComment(networkImage, commentUser!, textStyle, boxSpace, commentFirst);
        },
      ),
    );
  }

  // C A R D -- C O M M E N T
  Widget _cardComment(NetworkImageWidget networkImage, User user, TextStyleCustom textStyle, BoxSpace boxSpace, Comment comment) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: StyleSize(context).screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: StyleSize(context).widthPercent(40),
            height: StyleSize(context).heightPercent(40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: networkImage.networkImage(user.avatar!),
            ),
          ),
          boxSpace.spaceWidth(10, context),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.username,
                  softWrap: true,
                  style: textStyle.textStyleForm(14, FontWeight.w400, Colors.black), // Giữ nguyên kích thước font
                ),
                Wrap(
                  children: [
                    Text(
                      comment.content,
                      softWrap: true,
                      style: textStyle.textStyleForm(12, FontWeight.w300, Colors.black), // Giữ nguyên kích thước font
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textStyle.formatDateFromText(DateTime.now()),
                      softWrap: true,
                      style: textStyle.textStyleForm(12, FontWeight.w300, Colors.grey), // Giữ nguyên kích thước font
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          _cardCommentButton('like.svg', comment.likes, textStyle),
                          _cardCommentButton('comment.svg', comment.replies, textStyle),
                          _cardCommentButton('choice.svg', 0, textStyle)
                        ],
                      )
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // S H O W -- M O R E
  Widget _showMoreButton(TextStyleCustom textStyle){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
              border: Border.all(color: Colors.grey.withOpacity(0.3))
            ),
            child: Center(
              child: Text(
                "Show More",
                style: textStyle.textStyleForm(
                    12, FontWeight.w400, lightBlue),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // L I K E -- C M T -- S H A R E
  Widget _cardCommentButton(String url, int int, TextStyleCustom textStyle){
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/vectors/$url',width: 15,height: 15,),
          Text(
            '$int',
            softWrap: true,
            style: textStyle.textStyleForm(12, FontWeight.w300, Colors.black), // Giữ nguyên kích thước font
          ),
        ],
      ),
    );
  }
  
  // C O M M E N T -- F I E L D
  Widget _inputComment(
      TextEditingController controller,
      NetworkImageWidget networkImage,
      User currentUser,
      BoxSpace box,
      TextStyleCustom textStyle) {
    return Container(
      width: StyleSize(context).screenWidth,
      height: 40,
      decoration: BoxDecoration(
          color: lightBlue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: white), shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: networkImage.networkImage(currentUser.avatar!),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Leave a comment',
                  hintStyle: textStyle.textStyleForm(
                      12, FontWeight.w400, Colors.grey)),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              '❤️',
              style: TextStyle(fontSize: 18),
            ),
          ),
          box.spaceWidth(10, context),
          GestureDetector(
            onTap: () {},
            child: const Text(
              '😆',
              style: TextStyle(fontSize: 18),
            ),
          ),
          box.spaceWidth(10, context),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/vectors/choice.svg',
              width: 18,
              height: 18,
            ),
          ),
          box.spaceWidth(10, context),
        ],
      ),
    );
  }
}
