import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_travel_booking/model/comment.dart';
import 'package:flutter_travel_booking/model/post.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';

import '../model/user.dart';

class PostProvider extends StateNotifier<Post?> {
  PostProvider() : super(null);

  Post? _currentPost;
  bool _isDiscover = false;

  // G E T T E R
  Post? get currentPost => _currentPost;
  bool get isDiscover => _isDiscover;

  // S E T T E R
  Future<void> savePost(Post post) async {
    _currentPost = post;
  }

  // C R E A T E -- CMT
  Future<void> createComment(String content, TextStyleCustom textStyle) async {
    int postID = _currentPost!.id!;
    int userID = 1;
    int commentID = commentsList.length + 1;
    String commentContent = content.trim();
    String dateTime = textStyle.formatDateFromText(DateTime.now());
    Comment newComment = Comment(postID: postID, userID: userID, commentID: commentID, content: content);
    try {
      commentsList.add(newComment);
    } catch (e) {
      throw e;
    }
  }

  // T O G G L E -- D I S C O V E R -- M O R E
  Future<void> toggleDiscoverMore() async {
    _isDiscover = !_isDiscover;
  }


}

final postProvider = StateNotifierProvider<PostProvider, Post?>((ref) => PostProvider());
