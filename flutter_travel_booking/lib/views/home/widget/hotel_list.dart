import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/provider/post_provider.dart';
import 'package:flutter_travel_booking/provider/user_provider.dart';
import 'package:flutter_travel_booking/theme/image/network_image.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import 'package:flutter_travel_booking/views/post_detail/post_details_screen.dart';

import '../../../model/post.dart';
import '../../../model/user.dart';
import '../../../theme/color/color.dart';

class HotelGridViewWidget extends ConsumerStatefulWidget {
  const HotelGridViewWidget({super.key});

  @override
  ConsumerState<HotelGridViewWidget> createState() => _HotelGridViewWidgetState();
}

class _HotelGridViewWidgetState extends ConsumerState<HotelGridViewWidget> {
  late List<Post> posts;
  late List<User> users;
  final networkImage = NetworkImageWidget();
  final textStyle = TextStyleCustom();
  final boxSpace = BoxSpace();

  @override
  void initState() {
    users = usersList;
    posts = postsList;
    super.initState();
  }

  // Phương thức để xây dựng card cho bài post
  Widget _buildPostCard(Post post, User userIndex, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await ref.read(postProvider.notifier).savePost(post);
        Navigator.push(context, MaterialPageRoute(builder: (builder) => PostDetailScreen(user: userIndex)));
        debugPrint("Save post to current post success");
      },
      child: Card(
        elevation: 10,
        color: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Ảnh của bài post
            SizedBox(
              height: 150,
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation(1), // Có thể điều chỉnh opacity theo nhu cầu
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.images!.length,
                  itemBuilder: (context, index) {
                    final imageUrl = post.images![index].url;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      width: StyleSize(context).widthPercent(173),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        child: networkImage.networkImage(imageUrl!),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Hiển thị dấu ba chấm nếu tiêu đề quá dài
                style: textStyle.textStyleForm(12, FontWeight.w500, Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _author(userIndex.avatar!, userIndex.username),
                  _view('assets/vectors/eye.svg', (post.viewAmount!)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Author widget
  Widget _author(String avatar, String author) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: networkImage.networkImage(avatar),
          ),
        ),
        boxSpace.spaceWidth(5, context),
        Text(
          author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // Giới hạn chữ nếu quá dài
          style: textStyle.textStyleForm(10, FontWeight.w300, Colors.black),
        ),
      ],
    );
  }
  Widget _view(String avatar, int view) {
    return Row(
      children: [
        SvgPicture.asset(avatar,width: 20,height: 20,),
        boxSpace.spaceWidth(5, context),
        Text(
          '${_convertView(double.parse(view.toString()))}',
          style: textStyle.textStyleForm(10, FontWeight.w300, Colors.black),
        ),
      ],
    );
  }

  //Convert view to thousand view .k
  _convertView(double viewAmount) {
    if(viewAmount > 1000) {
      viewAmount = viewAmount / 1000;
      debugPrint(viewAmount.toString());
      String newViewAmount;
      newViewAmount = '$viewAmount\k';
      return newViewAmount;
    }
  }

  @override
  Widget build(BuildContext context) {

    //Create List<Map> save user and post
    final allPosts = users.expand((user) {
      return user.posts.map((post) => {'user': user, 'post': post});
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: StyleSize(context).heightPercent(500),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: StyleSize(context).heightPercent(255), // Điều chỉnh chiều cao của card
            mainAxisSpacing: 8,
            crossAxisSpacing: 10,
            childAspectRatio: 16 / 9,
          ),
          itemCount: allPosts.length,
          itemBuilder: (context, index) {
            final postData = allPosts[index];
            final post = postData['post'] as Post;
            final user = postData['user'] as User;

            // Gọi phương thức tạo thẻ bài post
            return _buildPostCard(post, user, ref);
          },
        ),
      ),
    );
  }
}


